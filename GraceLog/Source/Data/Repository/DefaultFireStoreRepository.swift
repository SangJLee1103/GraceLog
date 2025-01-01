//
//  DefaultFireStoreRepository.swift
//  GraceLog
//
//  Created by 이상준 on 12/30/24.
//

import Foundation
import Firebase
import RxSwift

final class DefaultFireStoreRepository: FireStoreRepository {
    func isUserExist(uid: String) -> Observable<Bool> {
        return .create { observer in
            COLLECTION_USER.document(uid).getDocument { snapshot, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = snapshot?.data() {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func registerUser(email: String, displayName: String) -> Observable<Result<UserDTO, Error>> {
        return .create { observer in
            if let uid = Auth.auth().currentUser?.uid {
                let user = UserDTO(
                    uid: uid,
                    displayName: displayName,
                    email: email,
                    photoUrl: "",
                    createdAt: Timestamp(date: Date())
                )
                
                do {
                    try COLLECTION_USER.document(uid).setData(from: user)
                    observer.onNext(.success(user))
                } catch {
                    observer.onNext(.failure(error))
                }
                observer.onCompleted()
            } else {
                observer.onNext(.failure(FirestoreError.userNotFound))
            }
            return Disposables.create()
        }
    }
}
