//
//  UserRequestDTO.swift
//  GraceLog
//
//  Created by 이상준 on 5/23/25.
//

import Foundation

struct UserRequestDTO: Encodable {
    let name: String
    let nickname: String
    let profileImage: String
    let email: String
    let message: String
}
