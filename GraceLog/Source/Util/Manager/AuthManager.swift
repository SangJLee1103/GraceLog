//
//  AuthManager.swift
//  GraceLog
//
//  Created by 이상준 on 5/22/25.
//

import Foundation

extension Notification.Name {
    static let authenticationFailed = Notification.Name("AuthenticationFailed")
}

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    func handleAuthenticationFailure() {
        DispatchQueue.main.async {
            KeyChainAccessImpl().removeAll()
            NotificationCenter.default.post(name: .authenticationFailed, object: nil)
        }
    }
}
