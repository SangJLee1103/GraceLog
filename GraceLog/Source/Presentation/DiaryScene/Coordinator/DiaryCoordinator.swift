//
//  DiaryCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 2/5/25.
//

import UIKit

final class DiaryCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childerCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
        setupNavigationBar()
    }
    
    func start() {
        // TODO
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        navigationController.navigationBar.tintColor = .black
    }
    
    func startPush() -> UINavigationController {
        let diaryVC = DiaryViewController()
        diaryVC.view.backgroundColor = .white
        diaryVC.title = "일기작성"
        diaryVC.reactor = DiaryViewReactor()
        navigationController.setViewControllers([diaryVC], animated: false)
        return navigationController
    }
}
