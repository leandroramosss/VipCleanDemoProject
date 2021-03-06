//
//  LoginInteractor.swift
//  VIPLogin
//
//  Created by Leandro Ramos on 10/29/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic {
    func startLoginRequest(request: LoginModel.Fetch.Request)
}

protocol LoginDataStore {
    var userData: User? { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var userData: User?
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    
    // MARK: Do something
            
    func startLoginRequest(request: LoginModel.Fetch.Request) {
        if worker == nil {
            worker = LoginWorker()
        }
        
        guard let emailValidation = worker?.validateEmail(email: request.email ?? "") else { return }
        
        if emailValidation {
            worker?.login(requestData: request, completionSuccess: { (response) in
                self.userData = response.user
                DispatchQueue.main.async {
                    if response.user?.statusCode == 200 {
                        self.presenter?.presentLogin(response: response)
                        self.presenter?.showMainPageAfterLogin()
                    } else {
                        self.presenter?.presentLoginError(error: "Login or password incorrect.")
                    }
                }
            }, completionFailure: { (error) in
                DispatchQueue.main.async {
                    self.presenter?.presentLoginError(error: error)
                    print("failure")
                }
            })
        } else {
            DispatchQueue.main.async {
                self.presenter?.presentLoginError(error: "usuário ou senha inválida")
            }
        }
    }
}
