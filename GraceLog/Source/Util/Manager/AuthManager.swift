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
    
    private init() {}
    
    func handleAuthenticationFailure() {
        DispatchQueue.main.async {
            KeyChainAccessImpl().removeAll()
            NotificationCenter.default.post(name: .authenticationFailed, object: nil)
        }
    }
    
    func saveUser(_ user: GraceLogUser) {
        self.user = user
        UserDefaults.standard.set(user.id, forKey: "user_id")
        UserDefaults.standard.set(user.name, forKey: "user_name")
        UserDefaults.standard.set(user.nickname, forKey: "user_nickname")
        UserDefaults.standard.set(user.profileImage, forKey: "user_profile_image")
        UserDefaults.standard.set(user.email, forKey: "user_email")
        UserDefaults.standard.set(user.message, forKey: "user_message")
    }
    
    func getUser() -> GraceLogUser? {
        if let user = self.user {
            return user
        }
        
        let id = UserDefaults.standard.integer(forKey: "user_id")
        let name = UserDefaults.standard.string(forKey: "user_name")
        let nickname = UserDefaults.standard.string(forKey: "user_nickname")
        let profileImage = UserDefaults.standard.string(forKey: "user_profile_image")
        let email = UserDefaults.standard.string(forKey: "user_email")
        let message = UserDefaults.standard.string(forKey: "user_message")
        
        if id != 0, let name = name, let nickname = nickname, let profileImage = profileImage, let email = email, let message = message  {
            let loadedUser = GraceLogUser(id: id, name: name, nickname: nickname,
                                          profileImage: profileImage, email: email, message: message)
            self.user = loadedUser
            return loadedUser
        }
        
        return nil
    }
    
    func removeUser() {
        self.user = nil
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "user_name")
        UserDefaults.standard.removeObject(forKey: "user_nickname")
        UserDefaults.standard.removeObject(forKey: "user_profile_image")
        UserDefaults.standard.removeObject(forKey: "user_email")
        UserDefaults.standard.removeObject(forKey: "user_message")
    }
}
