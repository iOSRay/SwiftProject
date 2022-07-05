//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by Waley on 6/20/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = ViewController.init()
        let navigation = UINavigationController.init(rootViewController: vc)
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigation;
        self.window?.makeKeyAndVisible()
        return true
    }


}

