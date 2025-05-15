//
//  UserService.swift
//  GraceLog
//
//  Created by 이상준 on 4/26/25.
//

import Foundation
import Alamofire
import RxSwift

struct AuthService {
    func signIn(request: SignInRequestDTO) -> Single<SignInResponseDTO> {
        return .create { single in
            AF.request(AuthTarget.signIn(request))
                .validate(statusCode: 200..<300)
                .responseDecodable(of: GraceLogResponseDTO<SignInResponseDTO>.self) { response in
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
