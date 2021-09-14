//
//  AppDelegate.swift
//  RebtelTakeHomeProject2
//
//  Created by Sebastian Mendez on 2021-09-13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = CountryListVC()
        let navVC = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navVC

        return true
    }
}
