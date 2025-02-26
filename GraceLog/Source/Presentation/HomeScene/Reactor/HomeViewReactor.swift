//
//  HomeViewReactor.swift
//  GraceLog
//
//  Created by 이상준 on 2/23/25.
//

import Foundation
import ReactorKit

enum CommunityItemType: String {
    case regular
    case my
}

struct CommunityResponse {
    let communityButtons: [CommunityButtonModel]
    let sections: [CommunitySectionType]
}

struct CommunityButtonModel {
    let imageName: String
    let title: String
}

struct CommunitySectionType {
    let date: String
    var items: [CommunityItem]
}

struct CommunityItem {
    let type: CommunityItemType
    let username: String?
    let title: String?
    let subtitle: String?
    let likes: Int?
    let comments: Int?
}

final class HomeViewReactor: Reactor {
    enum Action {
        case userButtonTapped
        case groupButtonTapped
    }
    
    enum Mutation {
        case setSegment(State.HomeModeSegment)
    }
    
    struct State {
        enum HomeModeSegment {
            case user
            case group
        }
        
        var currentSegment: HomeModeSegment = .user
        
        let communityResponse: CommunityResponse = CommunityResponse(
            communityButtons: [
                CommunityButtonModel(imageName: "community1", title: "홀리바이블"),
                CommunityButtonModel(imageName: "community2", title: "새문교회"),
                CommunityButtonModel(imageName: "community3", title: "스튜디오306"),
                CommunityButtonModel(imageName: "community4", title: "스터디카페")
            ],
            sections: [
                CommunitySectionType(
                    date: "2025년 2월 18일",
                    items: [
                        CommunityItem(type: .regular, username: "상준", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 1, comments: 2),
                        CommunityItem(type: .my, username: "승렬", title: "나는 느꼈다, 하나님께서...", subtitle: "#은혜 #코드 #사랑의 #스타디카페", likes: 4, comments: 4),
                        CommunityItem(type: .regular, username: "범철", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 2, comments: 3),
                        CommunityItem(type: .regular, username: "은재", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 3, comments: 3)
                    ]
                ),
                CommunitySectionType(
                    date: "2025년 2월 17일",
                    items: [
                        CommunityItem(type: .my, username: "승렬", title: "회사에서 함께하신 주님", subtitle: "#은혜 #코드 #사랑의 #스타디카페", likes: 3, comments: 2),
                        CommunityItem(type: .regular, username: "상준", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 4, comments: 1),
                        CommunityItem(type: .regular, username: "범철", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 3, comments: 5),
                        CommunityItem(type: .regular, username: "은재", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 5, comments: 4),
                        CommunityItem(type: .my, username: "승렬", title: "나는 느꼈다, 하나님께서...", subtitle: "#은혜 #코드 #사랑의 #스타디카페", likes: 4, comments: 4)
                    ]
                )
            ]
        )
        
        var communitySections: [CommunitySectionType] {
            return communityResponse.sections
        }
        
        var communityButtons: [CommunityButtonModel] {
            return communityResponse.communityButtons
        }
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .userButtonTapped:
            return .just(.setSegment(.user))
        case .groupButtonTapped:
            return .just(.setSegment(.group))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSegment(let segment):
            newState.currentSegment = segment
        }
        
        return newState
    }
}
