//
//  AppDelegate.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import UIKit
import IHProgressHUD
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupProgressHUD()
        setupNavigation()
        entryPoint()
        return true
    }
}

extension AppDelegate {
    private func setupNavigation() {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white!,
            .font: UIFont.SFUIText(.medium, size: 17)
        ]
        UINavigationBar.appearance().barTintColor = .greyishBrownTwo
    }
    private func entryPoint() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = HomeController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func setupProgressHUD() {
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(minimumDismiss: 0.3)
    }
}
