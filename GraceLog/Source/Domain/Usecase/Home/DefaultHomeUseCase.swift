//
//  DefaultHomeUseCase.swift
//  GraceLog
//
//  Created by 이상준 on 3/8/25.
//

import Foundation
import RxSwift

final class DefaultHomeUseCase: HomeUseCase {
    var homeMyData = BehaviorSubject<HomeContent?>(value: nil)
    var homeCommunityData = BehaviorSubject<HomeCommunityContent?>(value: nil)
    var user = BehaviorSubject<GraceLogUser?>(value: nil)
    var error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    private let userRepository: UserRepository
    private let homeRepository: HomeRepository
    
    init(userRepository: UserRepository, homeRepository: HomeRepository) {
        self.userRepository = userRepository
        self.homeRepository = homeRepository
    }
    
    func fetchHomeMyContent() {
        homeRepository.fetchHomeMyContent()
            .subscribe(
                onSuccess: { data in
                    self.homeMyData.onNext(data)
                },
                onFailure: { err in
                    self.error.onError(err)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchHomeCommunityContent() {
        homeRepository.fetchHomeCommunityContent()
            .subscribe(
                onSuccess: { data in
                    self.homeCommunityData.onNext(data)
                },
                onFailure: { err in
                    self.error.onError(err)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchUser() {
        userRepository.fetchUser()
            .subscribe(
                onSuccess: { user in
                    print("유저 \(user)")
                    self.user.onNext(user)
                },
                onFailure: { err in
                    self.error.onError(err)
                }
            )
            .disposed(by: disposeBag)
    }
}
