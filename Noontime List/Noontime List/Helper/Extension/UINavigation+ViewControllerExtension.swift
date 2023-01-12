//
//  UINavigation+ViewControllerExtension.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit

extension UIViewController {

    func viewController(storyboardName: String, identifier: String, isNavigation: Bool = false) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        if isNavigation {
            return UINavigationController(rootViewController: controller)
        }
        return controller
    }
}
