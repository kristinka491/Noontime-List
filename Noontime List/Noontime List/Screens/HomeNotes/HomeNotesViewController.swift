//
//  HomeNotesViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit

class HomeNotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func tappedAddButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "AddNoteScreen", identifier: "AddNoteScreen")
        navigationController?.pushViewController(controller, animated: true)
    }
}
