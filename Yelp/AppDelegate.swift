//
//  AppDelegate.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UIFont.overrideInitialize()

        window = UIWindow()
        let navController = UINavigationController(rootViewController: ListViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }

}

