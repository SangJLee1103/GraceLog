//
//  HomeContentDTO.swift
//  GraceLog
//
//  Created by 이상준 on 3/8/25.
//

import Foundation

struct HomeContentDTO: Decodable {
    let diaryList: [MyDiaryDTO]
    let videoList: [HomeVideoItemDTO]
}

struct HomeVideoItemDTO: Decodable {
    let title: String
    let imageName: String
}
