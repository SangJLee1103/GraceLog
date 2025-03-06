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
    let contentList: [HomeContentItem]
}

struct HomeContentItem {
    let title: String
    let image: UIImage?
}
