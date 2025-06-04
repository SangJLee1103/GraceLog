//
//  SearchCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit

final class SearchCoordinator: Coordinator {
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
        let searchVC = SearchViewController()
        searchVC.view.backgroundColor = .white
        navigationController.setViewControllers([searchVC], animated: false)
        return navigationController
    }
}
