//
//  GraceLogAuthenticator.swift
//  GraceLog
//
//  Created by 이상준 on 4/28/25.
//

import Foundation
import Alamofire
import RxSwift

class GraceLogAuthenticator: Authenticator {
    typealias Credential = GraceLogAuthenticationCredential
    private let baseURL: String
    private let disposeBag = DisposeBag()
    
    init(baseURL: String = "http://15.164.124.189:8080/api/v1") {
        self.baseURL = baseURL
    }
    
    
    func apply(_ credential: GraceLogAuthenticationCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
        urlRequest.addValue(credential.refreshToken, forHTTPHeaderField: "refresh-token")
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: any Error) -> Bool {
        return response.statusCode == 401 || response.statusCode == 403
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: GraceLogAuthenticationCredential) -> Bool {
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
    
    func refresh(_ credential: GraceLogAuthenticationCredential, for session: Alamofire.Session, completion: @escaping (Result<GraceLogAuthenticationCredential, any Error>) -> Void) {
        
        print("🔄 토큰 리프레시 시작")
        
        let url = "\(baseURL)/auth/refresh"
        
        let parameters: [String: String] = ["refreshToken": credential.refreshToken]
        print("리프레시 토큰", credential.refreshToken)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: GraceLogResponseDTO<SignInResponseDTO>.self) { response in
                print("📱 리프레시 응답: \(response.result)")
                switch response.result {
                case .success(let value):
                    if value.code == 200 {
                        let newCredential = GraceLogAuthenticationCredential(
                            accessToken: value.data.accessToken,
                            refreshToken: value.data.refreshToken,
                            expiredAt: Date(timeIntervalSinceNow: 60 * 120)
                        )
                        
                        KeychainServiceImpl.shared.accessToken = value.data.accessToken
                        KeychainServiceImpl.shared.refreshToken = value.data.refreshToken
                        
                        completion(.success(newCredential))
                    } else {
                        print("🔥 토큰 리프레시 실패 - code: \(value.code)")
                        AuthManager.shared.handleAuthenticationFailure()
                        completion(.failure(NSError(domain: "AuthError", code: 401, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    AuthManager.shared.handleAuthenticationFailure()
                }
            }
    }
}
