//
//  Extension+String.swift
//  VIPLogin
//
//  Created by Leandro Ramos on 11/1/20.
//

import Foundation
import UIKit

extension String {
    func isValidEmail(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
}
