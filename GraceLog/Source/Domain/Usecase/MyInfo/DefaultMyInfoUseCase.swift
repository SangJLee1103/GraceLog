//
//  DefaultMyInfoUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 5/23/25.
//

import Foundation
import RxSwift

final class DefaultMyInfoUseCase: MyInfoUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func updateUser(user: GraceLogUser) -> Single<GraceLogUser> {
        return userRepository.updateUser(user: user)
    }
}
