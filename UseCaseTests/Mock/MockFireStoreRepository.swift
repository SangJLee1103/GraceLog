//
//  MockFireStoreRepository.swift
//  GraceLogTests
//
//  Created by 이상준 on 1/1/25.
//

import Foundation
import RxSwift

@testable import GraceLog

final class MockFireStoreRepository: FireStoreRepository {
    func isUserExist(uid: String) -> Observable<Bool> {
        return .just(true)
    }
    
    func registerUser(email: String, displayName: String) -> Observable<Result<UserDTO, Error>> {
        let user = UserDTO(
            
        )
    }
    
    
}
