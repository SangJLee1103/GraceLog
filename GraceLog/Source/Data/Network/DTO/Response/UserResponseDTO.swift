//
//  UserDTO.swift
//  GraceLog
//
//  Created by 이상준 on 12/30/24.
//

import Foundation
import Firebase

struct UserResponseDTO: Codable {
    let memberId: Int
    let name: String
    let nickname: String
    let profileImage: String
}

extension UserResponseDTO {
    func toEntity() -> GraceLogUser {
        return GraceLogUser(
            id: memberId,
            name: name,
            nickname: nickname,
            profileImage: profileImage
        )
    }
}
