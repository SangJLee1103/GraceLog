//
//  LoginViewModel.swift
//  GraceLog
//
//  Created by 이상준 on 12/29/24.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import Firebase
import GoogleSignIn

final class LoginReactor: Reactor {
    weak var coordinator: LoginCoordinator?
    private let loginUseCase: LoginUseCase
    private var isAgreed: Bool = false
    private let disposeBag = DisposeBag()
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    enum Action {
        case googleLogin(AuthCredential)
        case appleLogin
        case toggleAgree
        case showTerms
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setError(Error)
        case setLoginSuccess(GraceLogUser)
        case setAgree(Bool)
    }
    
    struct State {
        var isLoading: Bool = false
        var error: Error? = nil
        var user: GraceLogUser? = nil
        var isAgreed: Bool = false
    }
    
    let initialState: State = State()
}

extension LoginReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .googleLogin(let credential):
            return Observable.concat([
                Observable.just(.setLoading(true)),
                signInWithCredential(credential),
                Observable.just(.setLoading(false))
            ])
        case .appleLogin:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.setLoading(false))
            ])
        case .toggleAgree:
            isAgreed = !isAgreed
            return .just(.setAgree(isAgreed))
        case .showTerms:
            // coordinator?.showTerms()
            return .empty()
        }
    }
    
    private func signInWithCredential(_ credential: AuthCredential) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create()}
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    observer.onNext(.setError(error))
                    observer.onCompleted()
                    return
                }
                
                guard let firebaseUser = result?.user else { return }
                
                self.loginUseCase.checkUserRegistration(uid: firebaseUser.uid)
                self.loginUseCase.isRegistered
                    .take(1)
                    .subscribe(onNext: { isRegistered in
                        if isRegistered {
                            self.loginUseCase.fetchUser(uid: firebaseUser.uid)
                        } else {
                            self.loginUseCase.registerUser(
                                email: firebaseUser.email ?? "",
                                displayName: firebaseUser.displayName ?? ""
                            )
                            self.loginUseCase.fetchUser(uid: firebaseUser.uid)
                        }
                    })
                    .disposed(by: self.disposeBag)
                
                self.loginUseCase.user
                    .take(1)
                    .withUnretained(self)
                    .subscribe(onNext: { owner, graceLogUser in
                        observer.onNext(.setLoginSuccess(graceLogUser))
                        owner.coordinator?.didFinishLogin()
                        observer.onCompleted()
                    })
                    .disposed(by: self.disposeBag)
            }
            return Disposables.create()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .setError(let error):
            newState.error = error
        case .setLoginSuccess(let user):
            newState.user = user
        case .setAgree(let isAgreed):
            newState.isAgreed = isAgreed
        }
        
        return newState
    }
}
