//
//  GraceLogAppCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 12/7/24.
//

import UIKit


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
    }
    
    func configureTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        let homeItem = UITabBarItem(title: "홈",
                                    image: UIImage(systemName: "house"),
                                    selectedImage: UIImage(systemName: "house.fill"))
        
        let bibleItem = UITabBarItem(title: "성경",
                                     image: UIImage(systemName: "book"),
                                     selectedImage: UIImage(systemName: "book.fill"))
        
        let myInfoItem = UITabBarItem(title: "내정보",
                                      image: UIImage(systemName: "person"),
                                      selectedImage: UIImage(systemName: "person.fill"))
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.parentCoordinator = self
        childerCoordinators.append(homeCoordinator)
        
        let homeVC = homeCoordinator.startPush()
        homeVC.tabBarItem = homeItem
        
        
        let bibleCoordinator = BibleCoordinator()
        bibleCoordinator.parentCoordinator = self
        childerCoordinators.append(bibleCoordinator)
        
        let bibleVC = bibleCoordinator.startPush()
        bibleVC.tabBarItem = bibleItem
        
        
        let myInfoCoordinator = MyInfoCoordinator()
        myInfoCoordinator.parentCoordinator = self
        childerCoordinators.append(myInfoCoordinator)
        
        let myInfoVC = myInfoCoordinator.startPush()
        myInfoVC.tabBarItem = myInfoItem
        
        tabBarController.viewControllers = [homeVC, bibleVC, myInfoVC]
        return tabBarController
    }
}
