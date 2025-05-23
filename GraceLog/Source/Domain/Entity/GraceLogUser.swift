//
//  GraceLogUser.swift
//  GraceLog
//
//  Created by 이상준 on 1/4/25.
//

import Foundation

struct GraceLogUser: Equatable {
    let id: Int
    let name: String
    let nickname: String
    let profileImage: String
    let email: String
    let message: String
}

extension GraceLogUser {
    func toRequestDTO() -> UserRequestDTO {
        return UserRequestDTO(
            name: name,
            nickname: nickname,
            profileImage: profileImage,
            message: message
        )
    }
}
