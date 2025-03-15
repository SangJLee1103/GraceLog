//
//  Community.swift
//  GraceLog
//
//  Created by 이상준 on 3/6/25.
//

import Foundation

struct HomeCommunityContent {
    var communityList: [CommunityItem]
    let diaryList: [CommunityDiary]
}

struct CommunityItem: Equatable {
    let imageName: String
    let title: String
    var isSelected: Bool = false
   
    static func == (lhs: CommunityItem, rhs: CommunityItem) -> Bool {
        return lhs.title == rhs.title
    }
}
