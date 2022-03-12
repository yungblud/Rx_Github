//
//  AppDelegate.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/11.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()

        let githubService = GithubService()
        let rootViewController = SearchViewController(githubService: githubService)
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = rootNavigationController

        self.window = window
        return true
    }
}

