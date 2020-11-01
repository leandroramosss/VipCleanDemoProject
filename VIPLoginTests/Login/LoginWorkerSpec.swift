//
//  LoginWorkerSpec.swift
//  VIPLoginTests
//
//  Created by Leandro Ramos on 10/31/20.
//

import XCTest
@testable import VIPLogin

class LoginWorkerSpec: XCTestCase {
    
    var sut: LoginWorker!
    
    override func setUp() {
        super.setUp()
        setupWorker()
    }
    
    func setupWorker() {
        sut = LoginWorker()
    }

    func testCreateRequest() {
        guard let url = URL(string: Constants.Urls.login) else { return }
        let requestData = LoginModel.Fetch.Request(email: "leandro@mailinator.com", password: "123456")
        let request = sut.performLogin(requestData: requestData, urlRequest: url)
        XCTAssertNotNil(request)
        XCTAssertEqual(request.httpMethod, "POST")
    }
    
    func testLoginRequest() {
        let expetation = XCTestExpectation(description: "validate login request")
        
        sut.login(requestData: LoginModel.Fetch.Request(email: "leandro@mailinator.com", password: "123456")) { (response) in
            XCTAssertNotNil(response)
            expetation.fulfill()
        } completionFailure: { (failure) in}
        wait(for: [expetation], timeout: 30.0)
    }
    
    func testValidateEmail() {
        let isValid = sut.validateEmail(email: "leandro@mailinator.com")
        
        XCTAssertTrue(isValid)
    }
}
