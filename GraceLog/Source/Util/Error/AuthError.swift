//
//  AuthError.swift
//  GraceLog
//
//  Created by 이상준 on 12/30/24.
//

import Foundation

enum AuthError: Error {
    case invalidCredential
    case userDisabled
    case userNotFound
    case operationNotAllowed
    case networkError
    case unknown(Error)
    
    init(from error: Error) {
        let nsError = error as NSError
        switch nsError.domain {
        case "auth/operation-not-allowed":
            self = .operationNotAllowed
        case "auth/invalid-credential":
            self = .invalidCredential
        case "auth/user-disabled":
            self = .userDisabled
        case "auth/user-not-found":
            self = .userNotFound
        case "auth/network-error":
            self = .networkError
        default:
            self = .unknown(error)
        }
    }
    
    var description: String {
        switch self {
        case .operationNotAllowed: return "해당 로그인 방식이 비활성화되어 있습니다"
        case .invalidCredential: return "유효하지 않은 인증 정보입니다"
        case .userDisabled: return "비활성화된 계정입니다"
        case .userNotFound: return "계정을 찾을 수 없습니다"
        case .networkError: return "네트워크 연결을 확인해주세요"
        case .unknown: return "알 수 없는 오류가 발생했습니다"
        }
    }
}
