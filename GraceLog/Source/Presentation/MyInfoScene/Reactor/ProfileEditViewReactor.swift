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
        case updateProfileImage(UIImage?)
        case updateNickname(String)
        case updateName(String)
        case updateMessage(String)
    }
    
    enum Mutation {
        case setSections([ProfileEditSectionModel])
        case setProfileImage(UIImage?)
        case setNickname(String)
        case setName(String)
        case setMessage(String)
    }
    
    struct State {
        var sections: [ProfileEditSectionModel] = []
        var profileImage: UIImage? = nil
        var nickname: String = ""
        var name: String = ""
        var message: String = ""
    }
    
    let initialState: State = State()
    weak var coordinator: ProfileEditCoordinator?
    
    init(coordinator: ProfileEditCoordinator? = nil) {
        self.coordinator = coordinator
    }
}

extension ProfileEditViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.just(createSections())
                .map { Mutation.setSections($0) }
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
        case .setProfileImage(let image):
            newState.profileImage = image
            
            if let index = newState.sections.indices.first {
                if case .imageItem = newState.sections[index].items.first {
                    let updatedItem = ProfileImageEditItem(image: image)
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
    
    private func createSections() -> [ProfileEditSectionModel] {
        let profileImageSection = ProfileEditSectionModel(items: [
            .imageItem(ProfileImageEditItem(image: currentState.profileImage))
        ])
        
        let profileInfoSection = ProfileEditSectionModel(items: [
            .infoItem(ProfileInfoEditItem(title: "닉네임", info: currentState.nickname), .nicknameEdit),
            .infoItem(ProfileInfoEditItem(title: "이름", info: currentState.nickname), .nameEdit),
            .infoItem(ProfileInfoEditItem(title: "메시지", info: currentState.nickname), .messageEdit),
        ])
        
        return [profileImageSection, profileInfoSection]
    }
}

// MARK: - For Coordinator
extension ProfileEditViewReactor {
    func showImagePicker(completion: @escaping (UIImage?) -> Void) {
        self.coordinator?.showImagePicker(completion: completion)
    }
}
