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

import CryptoKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    typealias Reactor = LoginReactor
    var disposeBag = DisposeBag()
    fileprivate var currentNonce: String?
    
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
        
        [startLabel, leftLine, rightLine, appleLoginButton, googleLoginButton, facebookLoginButton].forEach {
            $0.alpha = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.3,
            options: .curveEaseIn
        ) {
            [self.startLabel, self.leftLine, self.rightLine,
             self.appleLoginButton, self.googleLoginButton, self.facebookLoginButton].forEach {
                $0.alpha = 1
            }
        }
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
        
        appleLoginButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.handleAppleLogin()
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
    
    private func handleAppleLogin() {
        startSignInWithAppleFlow()
    }
}

extension LoginViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce else { return }
        
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        let credential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )
        
        reactor?.action.onNext(.appleLogin(credential))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In failed: \(error.localizedDescription)")
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? UIWindow()
    }
}
