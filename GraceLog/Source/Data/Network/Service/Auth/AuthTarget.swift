//
//  UserTarget.swift
//  GraceLog
//
//  Created by 이상준 on 4/26/25.
//

import Alamofire

enum AuthTarget {
    case signIn(SignInRequestDTO)
}

extension AuthTarget: TargetType {
    var baseURL: String {
        return "http://15.164.124.189:8080/api/v1/auth"
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn: return .post
        }
    }
    
    var path: String {
        switch self {
        case .signIn: return "/signin"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signIn(let request): return .body(request)
        }
    }
}
