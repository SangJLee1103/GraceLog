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
