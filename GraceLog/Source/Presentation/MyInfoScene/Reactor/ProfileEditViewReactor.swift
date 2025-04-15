//
//  ProfileEditViewReactor.swift
//  GraceLog
//
//  Created by 이상준 on 4/15/25.
//

import ReactorKit
import RxSwift
import RxCocoa

final class ProfileEditViewReactor: Reactor {
    enum Action {
        case viewDidLoad
        case updateProfileImage(String?)
        case updateNickname(String)
        case updateName(String)
        case updateMessage(String)
    }
    
    enum Mutation {
        case setSections([ProfileEditSectionModel])
        case setProfileImage(String?)
        case setNickname(String)
        case setName(String)
        case setMessage(String)
    }
    
    struct State {
        var sections: [ProfileEditSectionModel] = []
        var profileImage: String? = nil
        var nickname: String = ""
        var name: String = ""
        var message: String = ""
    }
    
    let initialState = State()
    
    init() { }
}

extension ProfileEditViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        case .updateProfileImage(let imageUrl):
            return .just(.setProfileImage(imageUrl))
        case .updateNickname(let nickname):
            return .just(.setNickname(nickname))
        case .updateName(let name):
            return .just(.setName(name))
        case .updateMessage(let message):
            return .just(.setMessage(message))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSections(let sections):
            newState.sections = sections
        case .setProfileImage(let imageUrl):
            newState.profileImage = imageUrl
            
            if let index = newState.sections.indices.first {
                if case .imageItem(let item) = newState.sections[index].items.first {
                    let updatedItem = ProfileImageEditItem(imageUrl: imageUrl)
                    newState.sections[index].items[0] = .imageItem(updatedItem)
                }
            }
        case .setNickname(let nickname):
            newState.nickname = nickname
        case .setName(let name):
            newState.name = name
        case .setMessage(let message):
            newState.message = message
        }
        
        return newState
    }
}
