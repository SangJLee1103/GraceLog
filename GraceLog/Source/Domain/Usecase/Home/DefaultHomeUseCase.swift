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
    var error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func fetchHomeMyContent() {
        repository.fetchHomeMyContent()
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
        repository.fetchHomeCommunityContent()
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
    
    //    func fetchCommunityDiary(communityID: Int) {
    //        <#code#>
    //    }
}
