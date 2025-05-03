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
                .validate()
                .responseDecodable(of: GraceLogResponseDTO<SignInResponseDTO>.self) { response in
                    print("로그인 \(response)")
                    switch response.result {
                    case .success(let response):
                        if response.code == 200 {
                            print("로그인 성공 \(response.data)")
                            single(.success(response.data))
                        }
                    case .failure(let error):
                        print("로그인 실패 \(error)")
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
