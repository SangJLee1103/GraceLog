//
//  UserDTO.swift
//  GraceLog
//
//  Created by 이상준 on 12/30/24.
//

import Foundation
import Firebase

struct UserDTO: Codable {
    let uid: String
    let displayName: String
    let email: String
    let photoUrl: String
    let createdAt: Timestamp
}

extension UserDTO {
    func toEntity() -> GraceLogUser {
        return GraceLogUser(
            uid: self.uid,
            displayName: self.displayName,
            email: self.email,
            photoUrl: self.photoUrl,
            createdAt: self.createdAt
        )
    }
}
