//
//  DiaryDetailsCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 6/8/25.
//

import UIKit

protocol DiaryDetailsCoordinatorDelegate: AnyObject {
    func diaryDetailsCoordinatorDidFinish(_ coordinator: DiaryDetailsCoordinator)
}

final class DiaryDetailsCoordinator: Coordinator {
    weak var delegate: DiaryDetailsCoordinatorDelegate?
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let diaryDetailsVC = DiaryDetailsViewController()
        diaryDetailsVC.coordinator = self 
        diaryDetailsVC.title = "나의 감사일기"
        NavigationBarUtil.setupMyDiaryAppearance()
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setViewControllers([diaryDetailsVC], animated: false)
    }
    
    func finish() {
        NavigationBarUtil.setupDefaultAppearance()
        delegate?.diaryDetailsCoordinatorDidFinish(self)
    }
}
