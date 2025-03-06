//
//  Community.swift
//  GraceLog
//
//  Created by 이상준 on 3/6/25.
//

import Foundation

struct CommunityDiary {
    let date: String
    var items: [CommunityDiaryItem]
}

struct CommunityDiaryItem {
    let type: CommunityItemType
    let username: String?
    let title: String?
    let subtitle: String?
    let likes: Int?
    let comments: Int?
}
