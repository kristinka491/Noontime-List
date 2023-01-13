//
//  AddNoteViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpLabel()
    }

    @IBAction private func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func tappedDoneButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    private func setUpButtonActivity() {
        let isEnabled = noteTitleTextField.text.isEmptyOrNil || noteBodyTextView.text.isEmptyOrNil
        doneButton.isEnabled = isEnabled
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitleColor(.systemGray, for: .disabled)
    }

    private func setUpLabel() {
        let date = Date()
        dateLabel.text = date.getFormattedDate(format: "EEEE, MMM d, yyyy")
    }
}

// MARK: -
// MARK: - UITextFieldDelegate

extension AddNoteViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        setUpButtonActivity()
    }
}

// MARK: -
// MARK: - UITextViewDelegate

extension AddNoteViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        setUpButtonActivity()
    }
}
