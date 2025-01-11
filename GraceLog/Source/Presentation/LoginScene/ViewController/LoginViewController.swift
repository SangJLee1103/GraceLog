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
    
    private lazy var googleLoginButton = LoginButton().then {
        $0.setStyle(type: .google, title: "Google로 로그인")
    }
    
    private lazy var appleLoginButton = LoginButton().then {
        $0.setStyle(type: .apple, title: "Apple로 계속하기")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let loginStack = UIStackView(arrangedSubviews: [googleLoginButton, appleLoginButton])
        loginStack.axis = .vertical
        loginStack.distribution = .fillEqually
        loginStack.spacing = 8
        
        [sloganLabel, logoImgView, loginStack].forEach {
            view.addSubview($0)
        }
        
        logoImgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(163)
            $0.height.equalTo(142)
        }
        
        sloganLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(logoImgView.snp.top).offset(-27)
        }
        
        loginStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(39)
            $0.top.equalTo(logoImgView.snp.bottom).offset(41)
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
