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
                .validate(statusCode: 200..<300)
                .responseDecodable(of: GraceLogResponseDTO<UserResponseDTO>.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.code == 200 {
                            single(.success(response.data))
                        }
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
