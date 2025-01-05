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
        $0.numberOfLines = 2
        $0.text = "우리의 감사로\n삶을 풍요롭게"
        $0.textColor = .themeYellow
        $0.font = UIFont(name: "Pretendard-Bold", size: 32)
    }
    
    private let logoImgView = UIImageView().then {
        $0.backgroundColor = .themeYellow
        $0.layer.cornerRadius = 25
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "Grace Log"
        $0.textColor = .themeYellow
        $0.font = UIFont(name: "Pretendard-Bold", size: 24)
    }
    
    private lazy var googleLoginButton = LoginButton().then {
        $0.setStyle(type: .google, title: "Google로 로그인")
    }
    
    private lazy var appleLoginButton = LoginButton().then {
        $0.setStyle(type: .apple, title: "Apple로 계속하기")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = Reactor(loginUseCase: DefaultLoginUseCase(firestoreRepository: DefaultFireStoreRepository()))
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let loginStack = UIStackView(arrangedSubviews: [googleLoginButton, appleLoginButton])
        loginStack.axis = .vertical
        loginStack.distribution = .fillEqually
        loginStack.spacing = 8
        
        [sloganLabel, logoImgView, titleLabel, loginStack].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        logoImgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top).offset(-16)
            $0.width.height.equalTo(84)
        }
        
        sloganLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(logoImgView.snp.top).offset(-33)
        }
        
        loginStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(39)
            $0.top.equalTo(titleLabel.snp.bottom).offset(115)
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
