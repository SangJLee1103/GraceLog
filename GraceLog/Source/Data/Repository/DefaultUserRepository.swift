//
//  DefaultFireStoreRepository.swift
//  GraceLog
//
//  Created by 이상준 on 12/30/24.
//

import Foundation
import RxSwift

final class DefaultUserRepository: UserRepository {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUser() -> Single<GraceLogUser> {
        return userService.fetchUser()
            .map { responseDTO in
                return GraceLogUser(
                    id: responseDTO.memberId,
                    name: responseDTO.name,
                    nickname: responseDTO.nickname,
                    profileImage: responseDTO.profileImage,
                    email: responseDTO.email,
                    message: responseDTO.message
                )
            }
    }
    
    func updateUser(user: GraceLogUser) -> Single<GraceLogUser> {
        return userService.updateUser(request: user.toRequestDTO())
            .map { responseDTO in
                return GraceLogUser(
                    id: responseDTO.memberId,
                    name: responseDTO.name,
                    nickname: responseDTO.nickname,
                    profileImage: responseDTO.profileImage,
                    email: responseDTO.email,
                    message: responseDTO.message
                )
            }
    }
}
