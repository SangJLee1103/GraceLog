//
//  UserTarget.swift
//  GraceLog
//
//  Created by 이상준 on 5/16/25.
//

import Alamofire

enum UserTarget {
    case fetchUser
    case updateUser(UserRequestDTO)
}

extension UserTarget: TargetType {
    var baseURL: String {
        return Const.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchUser: return .get
        case .updateUser: return .put
        }
    }
    
    var path: String {
        switch self {
        case .fetchUser, .updateUser: return "/member"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .fetchUser:
            return .none
        case .updateUser(let request):
            return .body(request)
        }
    }
}
