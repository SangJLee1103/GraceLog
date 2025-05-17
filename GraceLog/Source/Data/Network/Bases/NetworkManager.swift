//
//  NetworkManager.swift
//  GraceLog
//
//  Created by 이상준 on 4/28/25.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL: String
    let session: Session
    private let interceptor: AuthenticationInterceptor<GraceLogAuthenticator>
    private let authenticator: GraceLogAuthenticator
    
    
    private init() {
        self.baseURL = "http://15.164.124.189:8080/api/v1"
        self.authenticator = GraceLogAuthenticator()
        
        var credential: GraceLogAuthenticationCredential?
        
        if let accessToken = KeychainServiceImpl.shared.accessToken,
           let refreshToken = KeychainServiceImpl.shared.refreshToken {
            credential = GraceLogAuthenticationCredential(
                accessToken: accessToken,
                refreshToken: refreshToken,
                expiredAt: Date(timeIntervalSinceNow: 60 * 120)
            )
        }
        
        self.interceptor = AuthenticationInterceptor(
            authenticator: authenticator,
            credential: credential
        )
        
        self.session = Session(interceptor: interceptor)
    }
    
    func refreshSession() {
        if let accessToken = KeychainServiceImpl.shared.accessToken,
           let refreshToken = KeychainServiceImpl.shared.refreshToken {
            let credential = GraceLogAuthenticationCredential(
                accessToken: accessToken,
                refreshToken: refreshToken,
                expiredAt: Date(timeIntervalSinceNow: 60 * 120)
            )
            interceptor.credential = credential
        }
    }
}
