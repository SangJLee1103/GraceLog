//
//  HomeCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childerCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        // TODO
    }
    
    func startPush() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.view.backgroundColor = .white
        navigationController.setViewControllers([homeVC], animated: false)
        return navigationController
    }
}
