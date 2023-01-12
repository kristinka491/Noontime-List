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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }

    @IBAction private func tappedSkipButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "PlannerHomeScreen", identifier: "PlannerHomeScreen")
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction private func tappedNextButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "PlannerScreen", identifier: "PlannerScreen")
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setUpButton() {
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor.black.cgColor
        skipButton.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10
    }
}

