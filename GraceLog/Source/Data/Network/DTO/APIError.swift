//
//  NetworkError.swift
//  GraceLog
//
//  Created by 이상준 on 6/4/25.
//

import Foundation
import Alamofire

enum APIError: Error {
    case serverError(code: Int, message: String)
    case networkError(Error)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError(_, let message):
            return message
        case .networkError(let error):
            if let afError = error as? AFError {
                return mapAFErrorToKorean(afError)
            } else if let urlError = error as? URLError {
                return mapURLErrorToKorean(urlError)
            } else {
                return "네트워크 오류가 발생했습니다"
            }
        }
    }
    
    private func mapAFErrorToKorean(_ afError: AFError) -> String {
        switch afError {
        case .responseValidationFailed:
            return "서버 응답이 올바르지 않습니다"
        case .responseSerializationFailed:
            return "데이터 처리 중 오류가 발생했습니다"
        default:
            return "네트워크 오류가 발생했습니다"
        }
    }
    
    private func mapURLErrorToKorean(_ urlError: URLError) -> String {
        switch urlError.code {
        case .notConnectedToInternet:
            return "인터넷 연결을 확인해주세요"
        case .timedOut:
            return "요청 시간이 초과되었습니다"
        case .networkConnectionLost:
            return "네트워크 연결이 끊어졌습니다"
        case .cannotConnectToHost:
            return "서버에 연결할 수 없습니다"
        default:
            return "네트워크 오류가 발생했습니다"
        }
    }
}
