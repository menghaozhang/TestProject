//
//  AppDelegate.swift
//  TestProject
//
//  Created by Menghao Zhang on 2021-06-02.
//

import UIKit
import CalculatorProject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = CalculatorViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}

