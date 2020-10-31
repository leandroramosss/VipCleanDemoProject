//
//  LoginWorker.swift
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

typealias LoginResponseSuccess = (_ response: LoginModel.Fetch.Response) -> ()
typealias LoginResponseFailure = (_ response: String) -> ()

class LoginWorker {
    func doSomeWork() {
    }
    
    func performLogin(requestData: LoginModel.Fetch.Request, urlRequest: URL) -> URLRequest {
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "POST"
        request.httpBody = requestData.getBody()
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func login(requestData: LoginModel.Fetch.Request, completionSuccess: @escaping LoginResponseSuccess, completionFailure: @escaping LoginResponseFailure) {
        guard let urlRequest = URL(string: Constants.Urls.login) else {
            return
        }
        
        let request = performLogin(requestData: requestData, urlRequest: urlRequest)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completionFailure(error?.localizedDescription ?? "")
                return
            }
            
            guard let user = User.parse(responseData: data) else {
                completionFailure(error?.localizedDescription ?? "")
                return
            }
            
            completionSuccess(LoginModel.Fetch.Response(user: user))
        }.resume()
        
    }
    
}