//
//  HomeNotesCollectionViewCell.swift
//  Noontime List
//
//  Created by Vlad Birukov on 16.01.2023.
//

import UIKit

class HomeNotesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var borderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpCell(_ model: Note) {
        titleLabel.text = model.title
        bodyLabel.attributedText = model.body
        dateLabel.text = model.date
    }

    private func setUpView() {
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor(red: 250/255, green: 26/255, blue: 142/255, alpha: 1.00).cgColor
        borderView.layer.borderWidth = 1
    }

}
