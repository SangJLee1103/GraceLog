//
//  DefaultAuthRepository.swift
//  GraceLog
//
//  Created by 이상준 on 4/27/25.
//

import Foundation
import RxSwift

final class DefaultAuthRepository: AuthRepository {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn(provider: SignInProvider, token: String) -> Single<SignInResult> {
        let request = SignInRequestDTO(provider: provider, token: token)
        
        return authService.signIn(request: request)
            .map { responseDTO in
                return SignInResult(
                    accessToken: responseDTO.accessToken,
                    refreshToken: responseDTO.refreshToken,
                    isExist: responseDTO.isExist
                )
            }
    }
}
