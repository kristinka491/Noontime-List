//
//  AppDelegate.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpNavigationBar()
        setUpStartScreen()
        return true
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
    }

    private func showScreen(with storyboardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)

        let navigationController = UINavigationController(rootViewController: viewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func setUpStartScreen() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserOnboarded) {
            self.showScreen(with: "TabbarScreen", viewControllerName: "TabbarScreen")
        } else {
            self.showScreen(with: "HelloScreen", viewControllerName: "HelloScreen")
        }
    }

    private func setUpNavigationBar() {
        UINavigationBar.appearance().tintColor = .black
    }
}


