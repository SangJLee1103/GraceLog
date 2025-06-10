//
//  HomeCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
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
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        homeVC.view.backgroundColor = .white
        navigationController.setViewControllers([homeVC], animated: false)
        return navigationController
    }
    
    func showDiaryDetails(diaryItem: MyDiaryItem) {
        let diaryDetailsCoordinator = DiaryDetailsCoordinator()
        diaryDetailsCoordinator.delegate = self
        diaryDetailsCoordinator.parentCoordinator = self
        childCoordinators.append(diaryDetailsCoordinator)
        
        diaryDetailsCoordinator.start()
        navigationController.present(diaryDetailsCoordinator.navigationController, animated: true)
    }
}

extension HomeCoordinator: DiaryDetailsCoordinatorDelegate {
    func diaryDetailsCoordinatorDidFinish(_ coordinator: DiaryDetailsCoordinator) {
        dismissDiaryDetails()
    }
    
    func dismissDiaryDetails() {
        if let diaryDetailsCoordinator = childCoordinators.first(where: { $0 is DiaryDetailsCoordinator }) {
            childDidFinish(diaryDetailsCoordinator)
        }
        
        navigationController.dismiss(animated: true)
    }
}
