//
//  UserTarget.swift
//  GraceLog
//
//  Created by 이상준 on 5/16/25.
//

import Alamofire

enum UserTarget {
    case fetchUser
}

extension UserTarget: TargetType {
    var baseURL: String {
        return "http://15.164.124.189:8080/api/v1"
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchUser: return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchUser: return "/member"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .fetchUser: .none
        }
    }
}
