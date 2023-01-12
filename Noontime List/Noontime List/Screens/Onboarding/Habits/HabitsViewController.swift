//
//  HabitsViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }

    @IBAction private func tappedSkipButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "HomePlannerScreen", identifier: "HomePlannerScreen")
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction private func tappedNextButton(_ sender:  UIButton) {
        let controller = viewController(storyboardName: "NotesScreen", identifier: "NotesScreen")
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setUpButton() {
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor.black.cgColor
        skipButton.layer.cornerRadius = 20
        nextButton.layer.cornerRadius = 20
    }

}