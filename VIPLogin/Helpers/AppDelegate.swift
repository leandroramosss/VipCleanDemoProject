//
//  AppDelegate.swift
//  VIPLogin
//
//  Created by Leandro Ramos on 10/29/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13, *) {
            
        } else {
            self.window = UIWindow()
            let vc = LoginViewController()
            self.window!.rootViewController = vc
            self.window!.makeKeyAndVisible()
            self.window!.backgroundColor = .white
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

}

