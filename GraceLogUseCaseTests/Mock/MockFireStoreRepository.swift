//
//  MockFireStoreRepository.swift
//  GraceLogTests
//
//  Created by 이상준 on 1/1/25.
//

import Foundation
import RxSwift
import Firebase

@testable import GraceLog

final class MockFireStoreRepository: FireStoreRepository {
    var isUserExistReturn = true
    var user = UserDTO(
        uid: "Ymf08F27vRXcxuOI3sl6FAm07z22",
        displayName: "이상준",
        email: "sangjlee1103@gmail.com",
        photoUrl: "",
        createdAt: Timestamp(date: Date())
    )
    
    func isUserExist(uid: String) -> Observable<Bool> {
        return .just(uid == user.uid)
    }
    
    func registerUser(email: String, displayName: String) -> Observable<Result<UserDTO, Error>> {
        return .just(.success(user))
    }
    
    func fetchUser(uid: String) -> Observable<Result<GraceLogUser, Error>> {
        let graceLogUser = user.toEntity()
        return .just(.success(graceLogUser))
    }
}
