//
//  HomePlannerViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit

class HomePlannerViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        view.layoutIfNeeded()
    }

    private func setUpLabel() {
        let date = Date()
        dateLabel.text = date.getStringFromDate(format: "MMM d")
    }
}
