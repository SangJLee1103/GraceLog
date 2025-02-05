//
//  LoginCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 1/5/25.
//

import UIKit

final class LoginCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childerCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        //
    }
    
    func createLoginViewController() -> UIViewController {
        let loginVC = LoginViewController()
        let reactor = LoginReactor(
            loginUseCase: DefaultLoginUseCase(
                firestoreRepository: DefaultFireStoreRepository()
            )
        )
        reactor.coordinator = self
        loginVC.reactor = reactor
        return loginVC
    }
    
    func didFinishLogin() {
        if let appCoordinator = parentCoordinator as? GraceLogAppCoordinator {
            appCoordinator.window?.rootViewController?.dismiss(animated: true) { [weak self] in
                if let self = self {
                    appCoordinator.removeChildCoordinator(self)
                }
            }
        }
    }
}
