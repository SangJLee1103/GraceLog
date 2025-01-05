//
//  LoginRepository.swift
//  GraceLog
//
//  Created by 이상준 on 12/29/24.
//

import Foundation
import RxSwift

protocol FireStoreRepository {
    // MARK: - SignUp, Login
    func fetchUser(uid: String) -> Observable<Result<GraceLogUser, Error>>
    func isUserExist(uid: String) -> Observable<Bool>
    func registerUser(email: String,displayName: String) -> Observable<Result<UserDTO, Error>>
}
