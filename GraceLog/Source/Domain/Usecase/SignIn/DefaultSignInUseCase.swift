//
//  DefaultLoginUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 12/29/24.
//

import Foundation
import RxSwift

final class DefaultSignInUseCase: SignInUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func signIn(provider: SignInProvider, token: String) -> Single<SignInResult> {
        return authRepository.signIn(provider: provider, token: token)
    }
}
