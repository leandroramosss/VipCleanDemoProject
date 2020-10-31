//
//  LoginViewControllerSpec.swift
//  VIPLoginTests
//
//  Created by Leandro Ramos on 10/31/20.
//

import XCTest
@testable import VIPLogin

class LoginViewControllerSpec: XCTestCase {
    
    var sut: LoginViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setUpLoginViewController()
    }
    
    func setUpLoginViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
    }
    
    class LoginBusinessLogicSpy: LoginBusinessLogic {
        var startLoginRequestIsCalled = false
        
        func startLoginRequest(request: LoginModel.Fetch.Request) {
            startLoginRequestIsCalled = true
        }
        
    }
    
    func testDoLogin() {
        let spy = LoginBusinessLogicSpy()
        sut.interactor = spy
        
        sut.doLogin()
        
        XCTAssertTrue(spy.startLoginRequestIsCalled)
        
    }
    
}
