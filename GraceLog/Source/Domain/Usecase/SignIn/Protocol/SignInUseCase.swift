//
//  LoginUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 12/29/24.
//

import Foundation
import RxSwift

protocol SignInUseCase {
    func signIn(provider: SignInProvider, token: String) -> Single<SignInResult>
}
