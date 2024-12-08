//
//  BibleCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit

final class BibleCoordinator: Coordinator {
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
        let bibleVC = BibleViewController()
        bibleVC.view.backgroundColor = .white
        navigationController.setViewControllers([bibleVC], animated: false)
        return navigationController
    }
}
