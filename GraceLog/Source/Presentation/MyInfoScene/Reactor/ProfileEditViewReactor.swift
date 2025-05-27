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
        case didTapSaveButton
    }
    
    enum Mutation {
        case setSections([ProfileEditSectionModel])
        case setProfileImage(UIImage?)
        case setNickname(String)
        case setName(String)
        case setMessage(String)
        case setLoading(Bool)
        case setSaveSuccess(Bool)
        case setError(Error)
    }
    
    struct State {
        var sections: [ProfileEditSectionModel] = []
        var profileImage: UIImage? = nil
        var nickname: String = AuthManager.shared.getUser()?.nickname ?? ""
        var name: String = AuthManager.shared.getUser()?.name ?? ""
        var message: String = AuthManager.shared.getUser()?.message ?? ""
        var isLoading: Bool = false
        var saveSuccess: Bool = false
        var error: Error? = nil
    }
    
    let initialState: State = State()
    weak var coordinator: ProfileEditCoordinator?
    private let useCase: DefaultMyInfoUseCase
    
    init(coordinator: ProfileEditCoordinator? = nil, useCase: DefaultMyInfoUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}

extension ProfileEditViewReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable.just(createSections(state: initialState))
                .map { Mutation.setSections($0) }
        case .updateProfileImage(let imageUrl):
            return .just(.setProfileImage(imageUrl))
        case .updateNickname(let nickname):
            return .just(.setNickname(nickname))
        case .updateName(let name):
            return .just(.setName(name))
        case .updateMessage(let message):
            return .just(.setMessage(message))
        case .didTapSaveButton:
            return saveProfile()
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
            newState.sections = createSections(state: newState)
        case .setName(let name):
            newState.name = name
            newState.sections = createSections(state: newState)
        case .setMessage(let message):
            newState.message = message
            newState.sections = createSections(state: newState)
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setSaveSuccess(let success):
            newState.saveSuccess = success
        case .setError(let error):
            newState.error = error
        }
        
        return newState
    }
    
    private func createSections(state: State) -> [ProfileEditSectionModel] {
        let profileImageSection = ProfileEditSectionModel(items: [
            .imageItem(ProfileImageEditItem(image: state.profileImage))
        ])
        
        let profileInfoSection = ProfileEditSectionModel(items: [
            .infoItem(ProfileInfoEditItem(title: "닉네임", info: state.nickname, placeholder: "ex. Peter"), .nicknameEdit),
            .infoItem(ProfileInfoEditItem(title: "이름", info: state.name, placeholder: "ex. 베드로"), .nameEdit),
            .infoItem(ProfileInfoEditItem(title: "메시지", info: state.message, placeholder: "ex. 잠언 16:9"), .messageEdit),
        ])
        
        return [profileImageSection, profileInfoSection]
    }
    
    private func saveProfile() -> Observable<Mutation> {
        guard let user = AuthManager.shared.getUser() else { return .empty() }
        
        let updateUser = GraceLogUser(
            id: user.id,
            name: currentState.name,
            nickname: currentState.nickname,
            profileImage: AuthManager.shared.getUser()?.profileImage ?? "",
            email: user.email,
            message: currentState.message
        )
        
        return Observable.concat([
            .just(.setLoading(true)),
            useCase.updateUser(user: updateUser)
                .asObservable()
                .map { _ in .setSaveSuccess(true) }
                .catch { error in
                    .just(.setError(error)) },
            .just(.setLoading(false))
        ])
    }
}

// MARK: - For Coordinator
extension ProfileEditViewReactor {
    func showImagePicker(completion: @escaping (UIImage?) -> Void) {
        self.coordinator?.showImagePicker(completion: completion)
    }
}
