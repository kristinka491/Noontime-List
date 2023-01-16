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
    @IBOutlet weak var viewForBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpCell(_ model: Note) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
        dateLabel.text = model.date
    }

    private func setUpView() {
        viewForBackground.layer.cornerRadius = 10
    }

}
