//
//  MyDiaryDTO.swift
//  GraceLog
//
//  Created by 이상준 on 3/8/25.
//

import Foundation

struct MyDiaryDTO: Decodable {
    let date: String
    let dateDesc: String
    let title: String
    let subtitle: String
    let tags: [String]
    let imageName: String
}
