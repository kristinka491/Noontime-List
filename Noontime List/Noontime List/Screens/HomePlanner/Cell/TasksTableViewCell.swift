//
//  AddTaskTableViewCell.swift
//  Noontime List
//
//  Created by Vlad Birukov on 07.02.2023.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var borderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUp(_ model: Task) {
        taskNameLabel.text = model.name
        taskDescriptionLabel.text = model.body
    }

    private func setUpView() {
        borderView.layer.cornerRadius = 20
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1
    }
    
}
