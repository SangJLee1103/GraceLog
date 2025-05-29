//
//  ImagePickerManager.swift
//  GraceLog
//
//  Created by 이상준 on 5/29/25.
//

import UIKit
import YPImagePicker

final class ImagePickerManager {
    static func showImagePicker(
        from navigationController: UINavigationController,
        completion: @escaping (UIImage?) -> Void
    ) {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.showsPhotoFilters = false
        config.wordings.libraryTitle = "앨범"
        config.wordings.cancel = "취소"
        config.wordings.next = "다음"
        config.wordings.done = "완료"
        config.wordings.cameraTitle = "카메라"
        config.wordings.ok = "확인"
        
        NavigationBarUtil.setupImagePickerAppearance()
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { items, cancelled in
            if let photo = items.singlePhoto {
                completion(photo.image)
            } else {
                completion(nil)
            }
            picker.dismiss(animated: true)
        }
        
        navigationController.present(picker, animated: true) {
            NavigationBarUtil.setupDefaultAppearance()
        }
    }
}
