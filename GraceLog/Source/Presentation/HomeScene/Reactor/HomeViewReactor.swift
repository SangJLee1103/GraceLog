//
//  HomeViewReactor.swift
//  GraceLog
//
//  Created by 이상준 on 2/23/25.
//

import Foundation
import ReactorKit

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
    }
    
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
