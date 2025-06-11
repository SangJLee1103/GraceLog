//
//  DiaryCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 2/5/25.
//

import UIKit

final class DiaryCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let diaryVC = DiaryViewController()
        diaryVC.coordinator = self
        diaryVC.view.backgroundColor = .white
        diaryVC.title = "일기작성"
        diaryVC.reactor = DiaryViewReactor()
        navigationController.setViewControllers([diaryVC], animated: false)
    }
    
    func finish() {
        // TODO
    }
    
    func showAdditionalSettings() {
        let additionalSettingsVC = DiaryAdditionalSettingsViewController()
        additionalSettingsVC.title = "추가 설정"
        navigationController.pushViewController(additionalSettingsVC, animated: true)
    }
}
