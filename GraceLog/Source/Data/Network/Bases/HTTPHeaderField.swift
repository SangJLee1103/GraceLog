//
//  HTTPHeaderField.swift
//  GraceLog
//
//  Created by 이상준 on 4/26/25.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authenticationToken = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}
