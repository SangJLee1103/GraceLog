//
//  MyInfoViewController.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit

final class MyInfoCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        // TODO
    }
    
    func startPush() -> UINavigationController {
        let myInfoVC = MyInfoViewController()
        myInfoVC.view.backgroundColor = UIColor(hex: 0xF4F4F4)
        myInfoVC.title = "내 계정"
        myInfoVC.reactor = MyInfoViewReactor(coordinator: self)
        navigationController.setViewControllers([myInfoVC], animated: false)
        return navigationController
    }
    
    func showProfileEditVC() {
        let profileEditCoordinator = ProfileEditCoordinator(self.navigationController)
        profileEditCoordinator.parentCoordinator = self
        self.childCoordinators.append(profileEditCoordinator)
        profileEditCoordinator.start()
    }
}
