//
//  ProfileEditCoordinator.swift
//  GraceLog
//
//  Created by 이상준 on 4/17/25.
//

import UIKit
import YPImagePicker

final class ProfileEditCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childerCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.pushProfileEditViewController()
    }
    
    func pushProfileEditViewController() {
        let useCase = DefaultMyInfoUseCase(
            userRepository: DefaultUserRepository(
                userService: UserService()
            )
        )
        
        let reactor = ProfileEditViewReactor(coordinator: self, useCase: useCase)
        let profileEditVC = ProfileEditViewController()
        profileEditVC.reactor = reactor
        profileEditVC.title = "프로필 편집"
        
        self.navigationController.pushViewController(profileEditVC, animated: true)
    }
    
    func didFinishProfileEdit() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
    
    func showImagePicker(completion: @escaping (UIImage?) -> Void) {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.showsPhotoFilters = false
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { items, cancelled in
            if let photo = items.singlePhoto {
                completion(photo.image)
            } else {
                completion(nil)
            }
            picker.dismiss(animated: true)
        }
        
        self.navigationController.present(picker, animated: true)
    }
}
