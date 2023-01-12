//
//  ViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit

class HelloViewController: UIViewController {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpButton()
    }

    @IBAction private func tappedSkipButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "HomePlannerScreen", identifier: "HomePlannerScreen")
        navigationController?.pushViewController(controller, animated: true)
        userDefaults.set(true, forKey: UserDefaultsKeys.isUserOnboarded)
    }

    @IBAction private func tappedNextButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "PlannerScreen", identifier: "PlannerScreen")
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setUpButton() {
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor.black.cgColor
        skipButton.layer.cornerRadius = 20
        nextButton.layer.cornerRadius = 20
    }
}

