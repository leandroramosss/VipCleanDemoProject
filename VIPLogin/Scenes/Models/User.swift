//
//  User.swift
//  VIPLogin
//
//  Created by Leandro Ramos on 10/31/20.
//

import Foundation

struct User: Codable {
    let token: String?
    let name: String?
    let email: String?
    let password: String?
    let statusCode: Int?
}

struct LoginError: Codable {
    
}

extension User {
    static func parse(responseData: Data?) -> User? {
        var user: User?
        guard let data = responseData else {
            return user
        }
        
        do {
            let decoder = JSONDecoder()
            user = try decoder.decode(User.self, from: data)
        } catch let err {
            print("Error: ", err)
        }
        return user
    }
}
