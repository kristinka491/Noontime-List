//
//  NotesViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!

    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpButton()
    }

    @IBAction private func tappedGetStartedButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "HomePlannerScreen", identifier: "HomePlannerScreen")
        navigationController?.pushViewController(controller, animated: true)
        userDefaults.set(true, forKey: UserDefaultsKeys.isUserOnboarded)
    }

    private func setUpButton() {
        getStartedButton.layer.borderWidth = 1
        getStartedButton.layer.borderColor = UIColor.black.cgColor
        getStartedButton.layer.cornerRadius = 20

    }
}
