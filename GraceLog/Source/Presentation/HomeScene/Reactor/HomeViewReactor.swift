//
//  HomeViewReactor.swift
//  GraceLog
//
//  Created by 이상준 on 2/23/25.
//

import Foundation
import ReactorKit
import RxDataSources

enum CommunityItemType: String {
    case regular
    case my
}

final class HomeViewReactor: Reactor {
    enum Action {
        case userButtonTapped
        case groupButtonTapped
        case selectCommunity(item: CommunityItem)
    }
    
    enum Mutation {
        case setSegment(State.HomeModeSegment)
        case setCommunityIndex(CommunityItem)
    }
    
    struct State {
        enum HomeModeSegment {
            case user
            case group
        }
        
        var currentSegment: HomeModeSegment = .user
        
        let myResponse: HomeContent = HomeContent(
            diaryList: [
                MyDiaryItem(
                    date: "오늘\n2/14",
                    dateDesc: "오늘의 감사일기",
                    title: "스터디 카페에 새로운 손님이?",
                    subtitle: "나는 느꼈다,\n하나님께서 하심을",
                    tags: ["#순종", "#도전", "#새해", "#스터디카페"],
                    image: UIImage(named: "diary1")
                ),
                MyDiaryItem(
                    date: "지난주\n2/7",
                    dateDesc: "지난주 이시간",
                    title: "어쩌다 보니 창업...",
                    subtitle: "",
                    tags: [],
                    image: UIImage(named: "diary2")
                ),
                MyDiaryItem(
                    date: "작년\n12/1",
                    dateDesc: "작년 12월",
                    title: "그럼에도 불구하고",
                    subtitle: "",
                    tags: [],
                    image: UIImage(named: "diary3")
                )
            ],
            contentList: [
                HomeContentItem(title: "말씀노트", image: UIImage(named: "content1") ?? UIImage()),
                HomeContentItem(title: "더메세지 랩The Message LAB", image: UIImage(named: "content2") ?? UIImage())
            ]
        )
        
        let communityResponse: Community = Community(
            communityList: [
                CommunityItem(imageName: "community1", title: "홀리바이블"),
                CommunityItem(imageName: "community2", title: "새롬교회"),
                CommunityItem(imageName: "community3", title: "스튜디오306"),
                CommunityItem(imageName: "community4", title: "스터디카페"),
                CommunityItem(imageName: "community1", title: "홀리바이블1"),
                CommunityItem(imageName: "community1", title: "홀리바이블2"),
                CommunityItem(imageName: "community1", title: "홀리바이블3"),
            ],
            diary: [
                CommunityDiary(
                    date: "2025년 2월 18일",
                    items: [
                        CommunityDiaryItem(type: .regular, username: "상준", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 1, comments: 2),
                        CommunityDiaryItem(type: .my, username: "승렬", title: "나는 느꼈다, 하나님께서...", subtitle: "#은혜 #코드 #사랑의 #스타디카페", likes: 4, comments: 4),
                        CommunityDiaryItem(type: .regular, username: "범철", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 2, comments: 3),
                        CommunityDiaryItem(type: .regular, username: "은재", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 3, comments: 3)
                    ]
                ),
                CommunityDiary(
                    date: "2025년 2월 17일",
                    items: [
                        CommunityDiaryItem(type: .my, username: "승렬", title: "회사에서 함께하신 주님", subtitle: "#은혜 #코드 #사랑의 #스타디카페", likes: 3, comments: 2),
                        CommunityDiaryItem(type: .regular, username: "상준", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 4, comments: 1),
                        CommunityDiaryItem(type: .regular, username: "범철", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 3, comments: 5),
                        CommunityDiaryItem(type: .regular, username: "은재", title: "회사에서 함께하신 주님", subtitle: "#식당 #부엌 #땀 #코드", likes: 5, comments: 4),
                        CommunityDiaryItem(type: .my, username: "승렬", title: "나는 느꼈다, 하나님께서...", subtitle: "#은혜 #코드 #사랑의 #스타디카페", likes: 4, comments: 4)
                    ]
                )
            ]
        )
        
        var communitySections: [CommunityDiary] {
            return communityResponse.diary
        }
        
        var communityButtons: [CommunityItem] {
            return communityResponse.communityList
        }
        
        var selectedCommunity: CommunityItem?
        
        init() {
            currentSegment = .user
            
            if !communityResponse.communityList.isEmpty {
                selectedCommunity = communityResponse.communityList[0]
            }
        }
    }
    
    let initialState: State = State()
    
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
        }
        
        return newState
    }
}
