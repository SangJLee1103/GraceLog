//
//  FirestoreError.swift
//  GraceLog
//
//  Created by 이상준 on 12/30/24.
//

import Foundation

enum FirestoreError: Error {
    case documentNotSaved
    case userNotFound
    
    var description: String {
        switch self {
        case .documentNotSaved: return "데이터 저장에 실패했습니다"
        case .userNotFound: return "사용자를 찾을 수 없습니다"
        }
    }
}
