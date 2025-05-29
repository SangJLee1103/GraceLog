//
//  Const.swift
//  GraceLog
//
//  Created by 이상준 on 4/27/25.
//

import Foundation

struct Const {
    static let kakaoKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String ?? ""
    static let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    
    private init() {}
}
