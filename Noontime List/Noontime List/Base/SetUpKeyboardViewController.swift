//
//  SetUpKeyboard.swift
//  Noontime List
//
//  Created by Vlad Birukov on 17.01.2023.
//

import Foundation
import UIKit

class SetUpKeyboardViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    private let bottomSpace = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
    }

    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint.constant = keyboardHeight - CGFloat(bottomSpace)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = CGFloat(bottomSpace)
    }
}
