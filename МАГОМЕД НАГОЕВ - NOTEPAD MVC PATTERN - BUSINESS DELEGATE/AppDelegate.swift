//
//  AppDelegate.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit
import UniformTypeIdentifiers

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let textViewer = TextViewer()
//        let navigationController = UINavigationController(rootViewController: textViewer)
        
//        window?.rootViewController = navigationController
        window?.rootViewController = ContainerViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

