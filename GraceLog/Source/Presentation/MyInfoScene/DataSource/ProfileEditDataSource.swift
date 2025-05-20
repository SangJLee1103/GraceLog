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
    let placeholder: String
}

enum ProfileEditItemType {
    case imageEdit
    case nicknameEdit
    case nameEdit
    case messageEdit
}

struct ProfileEditSectionModel: Equatable {
    var items: [ProfileEditItem]
}

extension ProfileEditSectionModel: SectionModelType {
    typealias Item = ProfileEditItem
    
    init(original: ProfileEditSectionModel, items: [ProfileEditItem]) {
        self = original
        self.items = items
    }
}

enum ProfileEditItem: Equatable {
    case imageItem(ProfileImageEditItem)
    case infoItem(ProfileInfoEditItem, ProfileEditItemType)
    
    static func == (lhs: ProfileEditItem, rhs: ProfileEditItem) -> Bool {
        switch (lhs, rhs) {
        case (.imageItem(let lhsItem), .imageItem(let rhsItem)):
            return lhsItem.image === rhsItem.image
            
        case (.infoItem(let lhsItem, let lhsType), .infoItem(let rhsItem, let rhsType)):
            return lhsItem.title == rhsItem.title &&
            lhsItem.info == rhsItem.info &&
            lhsItem.placeholder == rhsItem.placeholder &&
            lhsType == rhsType
            
        default:
            return false
        }
    }
}

// ProfileImageEditItem에도 Equatable 구현
extension ProfileImageEditItem: Equatable {
    static func == (lhs: ProfileImageEditItem, rhs: ProfileImageEditItem) -> Bool {
        return lhs.image === rhs.image
    }
}

// ProfileInfoEditItem에도 Equatable 구현
extension ProfileInfoEditItem: Equatable {
    static func == (lhs: ProfileInfoEditItem, rhs: ProfileInfoEditItem) -> Bool {
        return lhs.title == rhs.title &&
        lhs.info == rhs.info &&
        lhs.placeholder == rhs.placeholder
    }
}
