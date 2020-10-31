//
//  LoginModels.swift
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

enum Login {
    // MARK: Use cases
    
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}

enum LoginModel {
    
    enum Fetch {
        
        struct Request {
            let email: String?
            let password: String?
            
            func getBody() -> Data {
                let data = ["email": email, "password": password]
                let jsonData = try? JSONSerialization.data(withJSONObject: data)
                return jsonData!
            }
            
        }
        
        struct Response {
            let user: User?
        }
        
        struct ViewModel {
            let token: String
            let name: String
            let email: String
            let password: String
            let statusCode: Int
        }
    }
}
