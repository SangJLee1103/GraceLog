//
//  LoginUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 12/29/24.
//

import Foundation
import RxSwift

protocol LoginUseCase {
    var isRegistered: PublishSubject<Bool> { get set }
    var isRegisterUser: PublishSubject<Bool> { get set }
    func checkUserRegistration(uid: String)
    func registerUser(email: String, displayName: String)
}
