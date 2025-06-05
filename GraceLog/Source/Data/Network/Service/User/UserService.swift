//
//  UserService.swift
//  GraceLog
//
//  Created by 이상준 on 5/16/25.
//

import Foundation
import Alamofire
import RxSwift

struct UserService {
    func fetchUser() -> Single<UserResponseDTO> {
        return .create { single in
            NetworkManager.shared.session.request(UserTarget.fetchUser)
                .responseDecodable(of: GraceLogResponseDTO<UserResponseDTO>.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.code == 200, let data = response.data {
                            single(.success(data))
                        } else {
                            let error = APIError.serverError(
                                code: response.code,
                                message: response.message
                            )
                            single(.failure(error))
                        }
                    case .failure(let error):
                        let apiError = APIError.networkError(error)
                        single(.failure(apiError))
                    }
                }
            return Disposables.create()
        }
    }
    
    func updateUser(request: UserRequestDTO) -> Single<UserResponseDTO> {
        return .create { single in
            NetworkManager.shared.session.request(UserTarget.updateUser(request))
                .responseDecodable(of: GraceLogResponseDTO<UserResponseDTO>.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.code == 200, let data = response.data {
                            single(.success(data))
                        } else {
                            let error = APIError.serverError(
                                code: response.code,
                                message: response.message
                            )
                            single(.failure(error))
                        }
                    case .failure(let error):
                        let apiError = APIError.networkError(error)
                        single(.failure(apiError))
                    }
                }
            
            return Disposables.create()
        }
    }
}
