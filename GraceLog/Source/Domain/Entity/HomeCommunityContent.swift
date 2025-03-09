//
//  Community.swift
//  GraceLog
//
//  Created by 이상준 on 3/6/25.
//

import Foundation

struct HomeCommunityContent {
    let communityList: [CommunityItem]
    let diaryList: [CommunityDiary]
}

struct CommunityItem: Equatable {
    let imageName: String
    let title: String
}
