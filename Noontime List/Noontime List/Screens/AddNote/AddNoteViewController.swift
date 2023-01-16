//
//  AddNoteViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!

    enum TypeOfController: String {
        case add
        case edit
    }

    private let coreDataManager = CoreDataManager.shared
    private var note: Note?
    private var typeOfController: TypeOfController = .add

    private var isChanged: Bool {
        if let note = note {
            return noteTitleTextField.text != note.title || noteBodyTextView.text != note.body
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpLabel()
        setUpDeleteButton()
        setUpTextField()
    }

    @IBAction private func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func tappedDoneButton(_ sender: UIButton) {
        if typeOfController == .add {
            saveNote()
        } else {
            updateNote()
        }
        navigationController?.popViewController(animated: true)
    }


    @IBAction private func tappedDeleteButton(_ sender: UIButton) {
        deleteNote()
        navigationController?.popViewController(animated: true)
    }

    func setUp(with note: Note, typeOfController: TypeOfController) {
        self.note = note
        self.typeOfController = typeOfController
    }

    func setUp(with typeOfController: TypeOfController) {
        self.typeOfController = typeOfController
    }

    private func setUpButtonActivity() {
        let isNotEmpty = !noteTitleTextField.text.isEmptyOrNil || !noteBodyTextView.text.isEmptyOrNil
        if typeOfController == .add {
            doneButton.isEnabled = isNotEmpty
        } else {
            doneButton.isEnabled = isNotEmpty && isChanged
        }
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitleColor(.systemGray, for: .disabled)
    }

    private func setUpLabel() {
        let date = Date()
        dateLabel.text = date.getStringFromDate(format: "EEEE, MMM d, yyyy")
    }

    private func setUpDeleteButton() {
        if typeOfController == .add {
            deleteButton.isHidden = true
        } else {
            deleteButton.isHidden = false
        }
    }

    private func setUpTextField() {
        if typeOfController == .edit {
            if let noteDate = note?.date,
               let noteTitle = note?.title,
               let noteBody = note?.body {
                dateLabel.text = noteDate
                noteTitleTextField.text = noteTitle
                noteBodyTextView.text = noteBody
            }
        }
    }


    private func saveNote() {
        let newNote = Note(context: coreDataManager.managedContext)
        newNote.setValue(dateLabel.text, forKey: #keyPath(Note.date))
        newNote.setValue(noteTitleTextField.text, forKey: #keyPath(Note.title))
        newNote.setValue(noteBodyTextView.text, forKey: #keyPath(Note.body))
        coreDataManager.saveContext()
    }

    private func updateNote() {
        note?.setValue(dateLabel.text, forKey: #keyPath(Note.date))
        note?.setValue(noteTitleTextField.text, forKey: #keyPath(Note.title))
        note?.setValue(noteBodyTextView.text, forKey: #keyPath(Note.body))
        coreDataManager.saveContext()
    }

    private func deleteNote() {
        if let note = note {
            coreDataManager.managedContext.delete(note)
            coreDataManager.saveContext()
        }
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
