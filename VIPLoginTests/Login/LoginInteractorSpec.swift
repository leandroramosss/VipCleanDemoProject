//
//  LoginInteractorSpec.swift
//  VIPLoginTests
//
//  Created by Leandro Ramos on 10/31/20.
//

import XCTest
@testable import VIPLogin

class LoginInteractorSpec: XCTestCase {
    
    var sut: LoginInteractor!
    
    override func setUp() {
        super.setUp()
        setupLoginInteractor()
    }
    
    func setupLoginInteractor() {
        sut = LoginInteractor()
    }

    class LoginWorkerSpy: LoginWorker {
        let loginPresentationLogic = LoginPresentationLogicSpy()
        
        override func login(requestData: LoginModel.Fetch.Request, completionSuccess: @escaping LoginResponseSuccess, completionFailure: @escaping LoginResponseFailure) {
            let response = LoginModel.Fetch.Response(user: nil)
            loginPresentationLogic.presentLogin(response: response)
        }
        
    }
    
    class LoginInteractorSpy: LoginInteractor {
        let loginPresentationLogic = LoginPresentationLogicSpy()
        override func startLoginRequest(request: LoginModel.Fetch.Request) {
            loginPresentationLogic.presentLoginError(error: "erro")
        }
    }
    
    class LoginPresentationLogicSpy: LoginPresentationLogic {
        var presentLoginIsCalled = false
        var presentLoginErrorIsCalled = false
        var presentMainPage = false
        
        func presentLogin(response: LoginModel.Fetch.Response) {
            presentLoginIsCalled = true
            
        }
        
        func presentLoginError(error: String) {
            presentLoginErrorIsCalled = true
        }
        
        func showMainPageAfterLogin() {
            presentMainPage = true
        }
        
    }
    
    func testPerformLogin() {
        let loginWorkerSpy = LoginWorkerSpy()
        sut.worker = loginWorkerSpy
        
        sut.startLoginRequest(request: LoginModel.Fetch.Request(email: "leandro@mailinator.com", password: "123456"))
        XCTAssertTrue(loginWorkerSpy.loginPresentationLogic.presentLoginIsCalled)
    }
    
    func testLoginError() {
        let interactorSpy = LoginInteractorSpy()
        
        interactorSpy.startLoginRequest(request: LoginModel.Fetch.Request(email: "leandro@mailinator.com", password: "123"))
    }
    
}


