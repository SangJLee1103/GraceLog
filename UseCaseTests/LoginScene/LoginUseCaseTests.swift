//
//  GraceLogTests.swift
//  GraceLogTests
//
//  Created by 이상준 on 12/7/24.
//

import XCTest
import RxSwift


final class LoginUseCaseTests: XCTestCase {
    private var disposeBag: DisposeBag!
    private var repository: FireStoreRepository!
    private var loginUseCase: LoginUseCase!
    
    override func setUpWithError() throws {
        self.disposeBag = DisposeBag()
        self.repository = MockFireStoreRepository()
        self.loginUseCase = DefaultLoginUseCase(firestoreRepository: self.repository)
    }
    
    override func tearDownWithError() throws {
        self.disposeBag = nil
        self.repository = nil
        self.loginUseCase = nil
    }
    
    func test_isRegistration_WhenSuccessful_shouldEmitTrue() {
        let expectation = XCTestExpectation()
        var result: Bool?
        
        loginUseCase.isRegistered
            .subscribe(onNext: { isRegistered in
                result = isRegistered
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        loginUseCase.checkUserRegistration(uid: "Ymf08F27vRXcxuOI3sl6FAm07z22")
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(result == true)
        
    }
    
    func test_registerUser_WhenSuccessful_ShouldEmitTrue() {
        // Given
        let expectation = XCTestExpectation()
        var result: Bool?
        
        // When
        loginUseCase.isRegisterUser
            .subscribe(onNext: { isRegistered in
                result = isRegistered
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // Then
        loginUseCase.registerUser(email: "sangjlee1103@gmail.com", displayName: "이상준")
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(result == true)
    }
    
    func test_fetchUser_WhenSuccessful_ShouldEmitUser() {
        // Given
        let expectation = XCTestExpectation()
        var resultUser: GraceLogUser?
        
        // When
        loginUseCase.user
            .subscribe(onNext: { user in
                resultUser = user
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        loginUseCase.fetchUser(uid: "Ymf08F27vRXcxuOI3sl6FAm07z22")
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(resultUser)
        XCTAssertEqual(resultUser?.email, "sangjlee1103@gmail.com")
    }
}
