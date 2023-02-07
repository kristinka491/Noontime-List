//
//  AddTaskViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 07.02.2023.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    private let coreDataManager = CoreDataManager.shared

    private var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        setUpButtonActivity()
    }

    @IBAction private func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func tappedDeleteButton(_ sender: UIButton) {

    }

    @IBAction private func tappedDoneButton(_ sender: UIButton) {
        saveTask()
        navigationController?.popViewController(animated: true)
    }

    func setUp(with selectedDate: Date) {
        self.selectedDate = selectedDate
    }

    private func setUpLabel() {
        dateLabel.text = selectedDate?.getStringFromDate(format: "EEEE, MMM d, yyyy")
    }

    private func setUpButtonActivity() {
        let isNotEmpty = !taskNameTextField.text.isEmptyOrNil || !taskDescriptionTextField.text.isEmptyOrNil
        doneButton.isEnabled = isNotEmpty
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitleColor(.systemGray, for: .disabled)
    }

    private func saveTask() {
        let newTask = Task(context: coreDataManager.managedContext)
        newTask.setValue(selectedDate, forKey: #keyPath(Task.date))
        newTask.setValue(taskNameTextField.text, forKey: #keyPath(Task.name))
        newTask.setValue(taskDescriptionTextField.text, forKey: #keyPath(Task.body))
        coreDataManager.saveContext()
    }
}

// MARK: -
// MARK: - UITextFieldDelegate

extension AddTaskViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        setUpButtonActivity()
    }
}

// MARK: -
// MARK: - UITextViewDelegate

extension AddTaskViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        setUpButtonActivity()
    }
}
