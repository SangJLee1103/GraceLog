//
//  HomeViewReactor.swift
//  GraceLog
//
//  Created by 이상준 on 2/23/25.
//

import Foundation
import ReactorKit
import RxDataSources

final class HomeViewReactor: Reactor {
    private let homeUsecase: HomeUseCase
    private let disposeBag = DisposeBag()
    
    init(homeUsecase: HomeUseCase) {
        self.homeUsecase = homeUsecase
        loadData()
    }
    
    private func loadData() {
        homeUsecase.fetchHomeMyContent()
        homeUsecase.fetchHomeCommunityContent()
    }
    
    enum Action {
        case userButtonTapped
        case groupButtonTapped
        case selectCommunity(item: CommunityItem)
    }
    
    enum Mutation {
        case setSegment(State.HomeModeSegment)
        case setCommunityIndex(CommunityItem)
        case setHomeMyData(HomeContent)
        case setHomeCommunityData(HomeCommunityContent)
        case setError(Error)
    }
    
    struct State {
        enum HomeModeSegment {
            case user
            case group
        }
        
        var currentSegment: HomeModeSegment = .user
        var selectedCommunity: CommunityItem?
        var homeMyData: HomeContent?
        var homeCommunityData: HomeCommunityContent?
        var communitySections: [(date: String, items: [CommunityDiaryItem])] = []
        var communityButtons: [String] = []
        var error: Error?
        
        var sections: [HomeSectionModel] {
            switch currentSegment {
            case .user:
                guard let myData = homeMyData else {
                    return []
                }
                
                let diaryItems = myData.diaryList.map { item in
                    return MyDiaryItem(
                        date: item.date,
                        dateDesc: item.dateDesc,
                        title: item.title,
                        subtitle: item.subtitle,
                        tags: item.tags,
                        image: item.image
                    )
                }
                
                let contentItems = myData.videoList.map { item in
                    return HomeVideoItem(
                        title: item.title,
                        imageName: item.imageName
                    )
                }
                
                return [
                    .diary(diaryItems),
                    .contentList(contentItems)
                ]
                
            case .group:
                guard let communityData = homeCommunityData else {
                    return []
                }
                
                let buttonItems = communityData.communityList.map { item in
                    return CommunityItem(
                        imageName: item.imageName, title: item.title
                    )
                }
                
                var sections: [HomeSectionModel] = [
                    .communityButtons(buttonItems)
                ]
                
                for sectionData in communityData.diaryList {
                    let items = sectionData.items.map { item in
                        return CommunityDiaryItem(
                            type: item.type,
                            username: item.username,
                            title: item.title,
                            subtitle: item.subtitle,
                            likes: item.likes,
                            comments: item.comments
                        )
                    }
                    
                    sections.append(.communityPosts(sectionData.date, items))
                }
                
                return sections
            }
        }
    }
    
    let initialState: State = State()
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let myDataMutation = homeUsecase.homeMyData
            .compactMap { $0 }
            .map { Mutation.setHomeMyData($0) }
        
        let communityDataMutation = homeUsecase.homeCommunityData
            .compactMap { $0 }
            .map { Mutation.setHomeCommunityData($0) }
        
        let errorMutation = homeUsecase.error
            .map { Mutation.setError($0) }
        
        return Observable.merge(
            mutation,
            myDataMutation,
            communityDataMutation,
            errorMutation
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .userButtonTapped:
            return .just(.setSegment(.user))
        case .groupButtonTapped:
            return .just(.setSegment(.group))
        case .selectCommunity(let model):
            return .just(.setCommunityIndex(model))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSegment(let segment):
            newState.currentSegment = segment
        case .setCommunityIndex(let model):
            newState.selectedCommunity = model
        case .setHomeMyData(let data):
            newState.homeMyData = data
        case .setHomeCommunityData(let data):
            newState.homeCommunityData = data
        case .setError(let error):
            newState.error = error
        }
        return newState
    }
}
