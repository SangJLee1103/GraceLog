//
//  ProfileEditDataSource.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import Foundation
import RxDataSources
import UIKit

struct ProfileImageEditItem {
    let image: UIImage?
}

struct ProfileInfoEditItem {
    let title: String
    let info: String
}

enum ProfileEditItemType {
    case imageEdit
    case nicknameEdit
    case nameEdit
    case messageEdit
}

struct ProfileEditSectionModel {
    var items: [ProfileEditItem]
}

extension ProfileEditSectionModel: SectionModelType {
    typealias Item = ProfileEditItem
    
    init(original: ProfileEditSectionModel, items: [ProfileEditItem]) {
        self = original
        self.items = items
    }
}

enum ProfileEditItem {
    case imageItem(ProfileImageEditItem)
    case infoItem(ProfileInfoEditItem, ProfileEditItemType)
}
