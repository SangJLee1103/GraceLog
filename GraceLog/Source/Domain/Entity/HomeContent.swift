//
//  HomeContent.swift
//  GraceLog
//
//  Created by 이상준 on 3/6/25.
//

import Foundation
import UIKit

struct HomeContent {
    let diaryList: [MyDiaryItem]
    let videoList: [HomeVideoItem]
}

struct HomeVideoItem {
    let title: String
    let imageName: String
}
