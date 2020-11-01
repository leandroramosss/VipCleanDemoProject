//
//  LoginPresenterSpec.swift
//  VIPLoginTests
//
//  Created by Leandro Ramos on 10/31/20.
//

import XCTest
@testable import VIPLogin

class LoginPresenterSpec: XCTestCase {

    var sut: LoginPresenter!
    
    override func setUp() {
        super.setUp()
        setupLoginPresenter()
    }
        
    func setupLoginPresenter() {
        sut = LoginPresenter()
    }

    class LoginDisplayLogicSpy: LoginDisplayLogic {
        var getDataIsCalled = false
        var displayErrorIsCalled = false
        var displayMainPage = false
        
        func getData(viewModel: LoginModel.Fetch.ViewModel) {
            getDataIsCalled = true
        }
        
        func displayErrorAlert(error: String) {
            displayErrorIsCalled = true
        }
        
        func transitionToMain() {
            displayMainPage = true
        }
        
    }
    
    func testPresentLogin() {
        let viewControllerSpy = LoginDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        let response = LoginModel.Fetch.Response(user: nil)
        
        sut.presentLogin(response: response)
        XCTAssert(viewControllerSpy.getDataIsCalled)
    }
    
    func testPresentLoginError() {
        let viewControllerSpy = LoginDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        sut.presentLoginError(error: "error")
        XCTAssertTrue(viewControllerSpy.displayErrorIsCalled)
    }
    
    func testTransitionToMain() {
        let viewControllerSpy = LoginDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        sut.showMainPageAfterLogin()
        XCTAssertTrue(viewControllerSpy.displayMainPage)
    }
    
}
