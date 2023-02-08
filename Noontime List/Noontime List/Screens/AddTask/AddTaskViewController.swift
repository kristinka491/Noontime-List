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

    enum TypeOfController: String {
        case add
        case edit
    }

    private let coreDataManager = CoreDataManager.shared
    private var typeOfController: TypeOfController = .add
    private var selectedDate: Date?
    private var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        setUpTextField()
        setUpButtonActivity()
        setUpDeleteButton()
    }

    @IBAction private func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func tappedDeleteButton(_ sender: UIButton) {
        deleteTask()
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func tappedDoneButton(_ sender: UIButton) {
        if typeOfController == .add {
            saveTask()
        } else {
            updateTask()
        }
        navigationController?.popViewController(animated: true)
    }

    func setUp(with selectedDate: Date, typeOfController: TypeOfController) {
        self.typeOfController = typeOfController
        self.selectedDate = selectedDate
    }

    func setUp(with task: Task, typeOfController: TypeOfController) {
        self.task = task
        self.typeOfController = typeOfController
    }

    private func setUpLabel() {
        if typeOfController == .add {
            dateLabel.text = selectedDate?.getStringFromDate(format: "EEEE, MMM d, yyyy")
        } else {
            if let task = task {
                dateLabel.text = task.date?.getStringFromDate(format: "EEEE, MMM d, yyyy")
            }
        }
    }

    private func setUpTextField() {
        if typeOfController == .edit {
            if let taskName = task?.name,
               let taskBody = task?.body {
                taskNameTextField.text = taskName
                taskDescriptionTextField.text = taskBody
            }
        }
    }


    private func setUpButtonActivity() {
        let isNotEmpty = !taskNameTextField.text.isEmptyOrNil || !taskDescriptionTextField.text.isEmptyOrNil
        doneButton.isEnabled = isNotEmpty
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitleColor(.systemGray, for: .disabled)
    }

    private func setUpDeleteButton() {
        if typeOfController == .add {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
        }
    }

    private func saveTask() {
        let newTask = Task(context: coreDataManager.managedContext)
        newTask.setValue(Calendar.current.startOfDay(for: selectedDate ?? Date()),
                         forKey: #keyPath(Task.date))
        newTask.setValue(taskNameTextField.text, forKey: #keyPath(Task.name))
        newTask.setValue(taskDescriptionTextField.text, forKey: #keyPath(Task.body))
        coreDataManager.saveContext()
    }

    private func updateTask() {
        task?.setValue(taskNameTextField.text, forKey: #keyPath(Task.name))
        task?.setValue(taskDescriptionTextField.text, forKey: #keyPath(Task.body))
        coreDataManager.saveContext()
    }

    private func deleteTask() {
        if let task = task {
            coreDataManager.managedContext.delete(task)
            coreDataManager.saveContext()
        }
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
