//
//  GraceLogAppCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/7/24.
//

import UIKit
import Firebase


final class GraceLogAppCoordinator: Coordinator {
    var childerCoordinators: [Coordinator] = []
    let window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let mainTabViewController = configureTabBarController()
        self.window?.rootViewController = mainTabViewController
        
        if Auth.auth().currentUser == nil {
            showLoginFlow()
        }
    }
    
    private func showLoginFlow() {
        guard let mainTabViewController = window?.rootViewController else { return }
        
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.parentCoordinator = self
        childerCoordinators.append(loginCoordinator)
        
        let loginVC = loginCoordinator.createLoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        mainTabViewController.present(loginVC, animated: true)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childerCoordinators.firstIndex(where: { $0 === coordinator }) {
            childerCoordinators.remove(at: index)
        }
    }
    
    func configureTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor(hex: 0x8C8C8C)
        appearance.shadowImage = UIImage()
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Pretendard-Medium", size: 10) ?? .systemFont(ofSize: 10)
        ]
        itemAppearance.selected.titleTextAttributes = [
            .font: UIFont(name: "Pretendard-Medium", size: 10) ?? .systemFont(ofSize: 10)
        ]
        appearance.stackedLayoutAppearance = itemAppearance
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        
        let homeItem = UITabBarItem(title: "홈",
                                    image: UIImage(named: "tab_home"),
                                    selectedImage: UIImage(systemName: "house.fill"))
        
        let diaryItem = UITabBarItem(title: "일기작성",
                                     image: UIImage(named: "tab_edit"),
                                     selectedImage: UIImage(systemName: "house.fill"))
        
        let searchItem = UITabBarItem(title: "찾기",
                                      image: UIImage(named: "tab_search"),
                                      selectedImage: UIImage(systemName: "book.fill"))
        
        let myInfoItem = UITabBarItem(title: "계정",
                                      image: UIImage(named: "tab_user"),
                                      selectedImage: UIImage(systemName: "person.fill"))
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.parentCoordinator = self
        childerCoordinators.append(homeCoordinator)
        
        let homeVC = homeCoordinator.startPush()
        homeVC.tabBarItem = homeItem
        
        let diaryCoordinator = DiaryCoordinator()
        diaryCoordinator.parentCoordinator = self
        childerCoordinators.append(diaryCoordinator)
        
        let diaryVC = diaryCoordinator.startPush()
        diaryVC.tabBarItem = diaryItem
        
        let searchCoordinator = SearchCoordinator()
        searchCoordinator.parentCoordinator = self
        childerCoordinators.append(searchCoordinator)
        
        let searchVC = searchCoordinator.startPush()
        searchVC.tabBarItem = searchItem
        
        
        let myInfoCoordinator = MyInfoCoordinator()
        myInfoCoordinator.parentCoordinator = self
        childerCoordinators.append(myInfoCoordinator)
        
        let myInfoVC = myInfoCoordinator.startPush()
        myInfoVC.tabBarItem = myInfoItem
        
        tabBarController.viewControllers = [homeVC, diaryVC, searchVC, myInfoVC]
        return tabBarController
    }
}
