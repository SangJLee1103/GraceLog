//
//  SignInResponseDTO.swift
//  GraceLog
//
//  Created by 이상준 on 4/26/25.
//

import Foundation

struct SignInResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let isExist: Bool
}
