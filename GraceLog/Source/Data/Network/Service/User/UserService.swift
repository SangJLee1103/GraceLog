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
    //    func fetchUser() -> Single<UserResponseDTO> {
    //        return .create { single in
    //            NetworkManager.shared.session.request(UserTarget.fetchUser)
    //                .validate(statusCode: 200..<300)
    //                .responseDecodable(of: GraceLogResponseDTO<UserResponseDTO>.self) { response in
    //                    switch response.result {
    //                    case .success(let response):
    //                        if response.code == 200 {
    //                            single(.success(response.data))
    //                        }
    //                    case .failure(let error):
    //                        single(.failure(error))
    //                    }
    //                }
    //            return Disposables.create()
    //        }
    //    }
    
    func fetchUser() -> Single<UserResponseDTO> {
        return .create { single in
            let request = NetworkManager.shared.session.request(UserTarget.fetchUser)
            
            request.validate(statusCode: 200..<300)
                .responseDecodable(of: GraceLogResponseDTO<UserResponseDTO>.self) { response in
                    print("Request URL: \(response.request?.url?.absoluteString ?? "Unknown")")
                    print("Request Method: \(response.request?.httpMethod ?? "Unknown")")
                    print("Request Headers: \(response.request?.allHTTPHeaderFields ?? [:])")
                    
                    print("Response Status Code: \(response.response?.statusCode ?? 0)")
                    print("Response Error: \(response.error?.localizedDescription ?? "None")")
                    
                    switch response.result {
                    case .success(let response):
                        if response.code == 200 {
                            single(.success(response.data))
                        }
                    case .failure(let error):
                        print("에러", error)
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
