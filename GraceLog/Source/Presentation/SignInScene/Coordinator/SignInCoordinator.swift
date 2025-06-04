//
//  LoginCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 1/5/25.
//

import UIKit

final class SignInCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        //
    }
    
    func createSignInViewController() -> UIViewController {
        let loginVC = SignInViewController()
        let reactor = SignInReactor(
            signInUseCase: DefaultSignInUseCase(authRepository: DefaultAuthRepository(authService: AuthService()))
        )
        reactor.coordinator = self
        loginVC.reactor = reactor
        return loginVC
    }
    
    func didFinishSignIn() {
        if let appCoordinator = parentCoordinator as? GraceLogAppCoordinator {
            appCoordinator.window?.rootViewController?.dismiss(animated: true) { [weak self] in
                if let self = self {
                    appCoordinator.removeChildCoordinator(self)
                }
            }
        }
    }
}
