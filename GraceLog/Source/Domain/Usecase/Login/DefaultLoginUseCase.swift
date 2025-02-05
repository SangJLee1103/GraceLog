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
    var user = PublishSubject<GraceLogUser>()
    var error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    init(firestoreRepository: FireStoreRepository) {
        self.firestoreRepository = firestoreRepository
    }
    
    func fetchUser(uid: String) {
        return firestoreRepository.fetchUser(uid: uid)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user.onNext(user)
                case .failure(let error):
                    self?.error.onNext(error)
                }
            }, onError: { [weak self] error in
                self?.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    func checkUserRegistration(uid: String) {
        firestoreRepository.isUserExist(uid: uid)
            .subscribe(onNext: { [weak self] exists in
                self?.isRegistered.onNext(exists)
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
