//
//  DiaryDetailsCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 6/8/25.
//

import UIKit

final class DiaryDetailsCoordinator: Coordinator {
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
        let diaryDetailsVC = DiaryDetailsViewController()
        diaryDetailsVC.view.backgroundColor = .white
        diaryDetailsVC.title = "나의 감사일기"
        navigationController.setViewControllers([diaryDetailsVC], animated: false)
        return navigationController
    }
}
