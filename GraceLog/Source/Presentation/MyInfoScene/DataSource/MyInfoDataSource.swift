//
//  MyInfoDataSource.swift
//  GraceLog
//
//  Created by 이상준 on 3/15/25.
//

import Foundation
import RxDataSources

struct MyInfoItem {
    let icon: String
    let title: String
    let type: MyInfoItemType
}

enum MyInfoItemType {
    case myProfile
    case myCalendar
    case favoriteVerse
    case communityManagement
    case memberManagement
    case pushSetting
    case pushList
    case noticeBoard
    case versionInfo
    case inquiry
    case logout
    case withdrawal
}


enum MyInfoSection {
    case myInfo(title: String, items: [MyInfoItem])
    case community(title: String, items: [MyInfoItem])
    case notification(title: String, items: [MyInfoItem])
    case customerService(title: String, items: [MyInfoItem])
    case account(title: String, items: [MyInfoItem])
}

extension MyInfoSection: SectionModelType {
    typealias Item = MyInfoItem
    
    var items: [MyInfoItem] {
        switch self {
        case .myInfo(_, let items),
                .community(_, let items),
                .notification(_, let items),
                .customerService(_, let items),
                .account(_, let items):
            return items
        }
    }
    
    var title: String {
        switch self {
        case .myInfo(let title, _),
                .community(let title, _),
                .notification(let title, _),
                .customerService(let title, _),
                .account(let title, _):
            return title
        }
    }
    
    init(original: MyInfoSection, items: [MyInfoItem]) {
        switch original {
        case .myInfo(let title, _):
            self = .myInfo(title: title, items: items)
        case .community(let title, _):
            self = .community(title: title, items: items)
        case .notification(let title, _):
            self = .notification(title: title, items: items)
        case .customerService(let title, _):
            self = .customerService(title: title, items: items)
        case .account(let title, _):
            self = .account(title: title, items: items)
        }
    }
}
