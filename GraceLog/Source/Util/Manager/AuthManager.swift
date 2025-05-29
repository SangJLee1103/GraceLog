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
    private var user: GraceLogUser?
    private let keychain = KeyChainAccessImpl()
    
    private enum KeychainKeys {
        static let userKey = "grace_log_user"
    }
    
    private init() {}
    
    func handleAuthenticationFailure() {
        DispatchQueue.main.async {
            KeyChainAccessImpl().removeAll()
            NotificationCenter.default.post(name: .authenticationFailed, object: nil)
        }
    }
    
    func saveUser(_ user: GraceLogUser) {
        self.user = user
        
        if let encoded = try? JSONEncoder().encode(user),
           let jsonString = String(data: encoded, encoding: .utf8) {
            keychain.save(KeychainKeys.userKey, jsonString)
        }
    }
    
    func getUser() -> GraceLogUser? {
        if let user = self.user {
            return user
        }
        
        guard let jsonString = keychain.get(KeychainKeys.userKey),
              let data = jsonString.data(using: .utf8),
              let user = try? JSONDecoder().decode(GraceLogUser.self, from: data) else {
            return nil
        }
        
        self.user = user
        return user
    }
    
    func removeUser() {
        self.user = nil
        keychain.remove(KeychainKeys.userKey)
    }
}
