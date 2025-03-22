//
//  MyInfoViewController.swift
//  GraceLog
//
//  Created by 이상준 on 12/8/24.
//

import UIKit

final class MyInfoCoordinator: Coordinator {
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
        
        appearance.shadowColor = .clear
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        navigationController.navigationBar.tintColor = .black
    }
    
    func startPush() -> UINavigationController {
        let myInfoVC = MyInfoViewController()
        myInfoVC.view.backgroundColor = UIColor(hex: 0xF4F4F4)
        navigationController.setViewControllers([myInfoVC], animated: false)
        return navigationController
    }
}
