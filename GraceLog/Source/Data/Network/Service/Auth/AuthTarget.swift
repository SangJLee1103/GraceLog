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
        return "http://\(Const.baseURL)"
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
