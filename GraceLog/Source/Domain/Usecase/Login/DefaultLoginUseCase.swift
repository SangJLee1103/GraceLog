//
//  DefaultLoginUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 12/29/24.
//

import Foundation
import RxSwift

final class DefaultLoginUseCase: LoginUseCase {
    private let firestoreRepository: FireStoreRepository
    var isRegistered = PublishSubject<Bool>()
    var isRegisterUser = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    
    init(firestoreRepository: FireStoreRepository) {
        self.firestoreRepository = firestoreRepository
    }
    
    func checkUserRegistration(uid: String) {
        firestoreRepository.isUserExist(uid: uid)
            .subscribe(onNext: { [weak self] _ in
                self?.isRegistered.onNext(true)
            }, onError: { [weak self] _ in
                self?.isRegistered.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
    func registerUser(email: String, displayName: String) {
        firestoreRepository.registerUser(email: email, displayName: displayName)
            .subscribe(onNext: { [weak self] _ in
                self?.isRegisterUser.onNext(true)
            })
            .disposed(by: disposeBag)
    }
}
