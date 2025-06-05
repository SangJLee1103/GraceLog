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
                .responseDecodable(of: GraceLogResponseDTO<SignInResponseDTO>.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.code == 200, let data = response.data {
                            single(.success(data))
                        }  else {
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
