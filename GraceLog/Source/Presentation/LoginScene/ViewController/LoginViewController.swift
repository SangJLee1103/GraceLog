//
//  LoginViewController.swift
//  GraceLog
//
//  Created by 이상준 on 12/28/24.
//

import UIKit
import SnapKit
import Then
import ReactorKit

import Firebase
import GoogleSignIn
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    typealias Reactor = LoginReactor
    var disposeBag = DisposeBag()
    
    private let sloganLabel = UILabel().then {
        $0.text = "감사가 채우는 하루"
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Regular", size: 24)
    }
    
    private let logoImgView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    private let startLabel = UILabel().then {
        $0.text = "시작하기"
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-regular", size: 14)
        $0.textAlignment = .center
        $0.setDimensions(width: 74, height: 38)
    }
    
    private let leftLine = UIView().then {
        $0.backgroundColor = .themeColor
        $0.setDimensions(width: 78, height: 1)
    }

    private let rightLine = UIView().then {
        $0.backgroundColor = .themeColor
        $0.setDimensions(width: 78, height: 1)
    }
    
    private lazy var appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "apple"), for: .normal)
        $0.setDimensions(width: 60, height: 60)
    }
    
    private lazy var googleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "google"), for: .normal)
        $0.setDimensions(width: 60, height: 60)
    }
    
    private lazy var facebookLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "facebook"), for: .normal)
        $0.setDimensions(width: 60, height: 60)
    }
    
    private let copyrightLabel = UILabel().then {
        $0.text = "Copyright Ⓒ 에끌레시아 All Rights Reserved."
        $0.textColor = .themeColor
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        
        let loginStack = UIStackView(arrangedSubviews: [appleLoginButton, googleLoginButton, facebookLoginButton])
        loginStack.axis = .horizontal
        loginStack.distribution = .fillEqually
        loginStack.spacing = 27
        
        [sloganLabel, logoImgView, startLabel, leftLine, rightLine, loginStack, copyrightLabel].forEach {
            view.addSubview($0)
        }
        
        logoImgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
            $0.width.equalTo(163)
            $0.height.equalTo(142)
        }
        
        sloganLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(logoImgView.snp.top).offset(-27)
        }
        
        startLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(logoImgView.snp.bottom).offset(50)
        }
        
        leftLine.snp.makeConstraints {
            $0.centerY.equalTo(startLabel)
            $0.right.equalTo(startLabel.snp.left)
        }
        
        rightLine.snp.makeConstraints {
            $0.centerY.equalTo(startLabel)
            $0.left.equalTo(startLabel.snp.right)
        }

        
        loginStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(startLabel.snp.bottom).offset(16)
        }
        
        copyrightLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeArea).inset(20)
        }
    }
}

extension LoginViewController: View {
    func bind(reactor: LoginReactor) {
        googleLoginButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.handleGoogleLogin()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.user }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] user in
                if let user = user {
                    print("받은 유저 정보: \(user)")
                }
            })
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    private func handleGoogleLogin() {
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            reactor?.action.onNext(.googleLogin(credential))
        }
    }
}
