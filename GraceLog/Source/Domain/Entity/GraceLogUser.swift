//
//  GraceLogUser.swift
//  GraceLog
//
//  Created by 이상준 on 1/4/25.
//

import Foundation
import Firebase

struct GraceLogUser: Equatable {
    let uid: String
    let displayName: String
    let email: String
    let photoUrl: String
    let createdAt: Timestamp
}
