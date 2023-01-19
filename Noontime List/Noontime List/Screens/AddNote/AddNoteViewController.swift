//
//  AddNoteViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//

import UIKit
import CoreData

class AddNoteViewController: SetUpKeyboardViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var viewForChanges: UIView!
    @IBOutlet weak var boldButton: UIButton!
    @IBOutlet weak var italicButton: UIButton!
    @IBOutlet weak var underlineBotton: UIButton!
    @IBOutlet weak var listButton: UIButton!

    enum TypeOfController: String {
        case add
        case edit
    }

    private let coreDataManager = CoreDataManager.shared
    private var note: Note?
    private var typeOfController: TypeOfController = .add

    private var isChanged: Bool {
        if let note = note {
            return noteTitleTextField.text != note.title || noteBodyTextView.attributedText != note.body
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpLabel()
        setUpDeleteButton()
        setUpTextField()
        setUpView()
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

    @IBAction private func tappedBoldButton(_ sender: UIButton) {
        boldButton.isSelected = !boldButton.isSelected
        changeText()
    }

    @IBAction private func tappedItalicButton(_ sender: UIButton) {
        italicButton.isSelected = !italicButton.isSelected
        changeText()
    }

    @IBAction private func tappedUnderlineButton(_ sender: UIButton) {
        underlineBotton.isSelected = !underlineBotton.isSelected
        changeText()
    }

    @IBAction private func tappedListButton(_ sender: UIButton) {

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
                noteBodyTextView.attributedText = noteBody
            }
        }
    }

    private func setUpView() {
        viewForChanges.layer.cornerRadius = 10
    }

    private func saveNote() {
        let newNote = Note(context: coreDataManager.managedContext)
        newNote.setValue(dateLabel.text, forKey: #keyPath(Note.date))
        newNote.setValue(noteTitleTextField.text, forKey: #keyPath(Note.title))
        newNote.setValue(noteBodyTextView.attributedText, forKey: #keyPath(Note.body))
        coreDataManager.saveContext()
    }

    private func updateNote() {
        note?.setValue(dateLabel.text, forKey: #keyPath(Note.date))
        note?.setValue(noteTitleTextField.text, forKey: #keyPath(Note.title))
        note?.setValue(noteBodyTextView.attributedText, forKey: #keyPath(Note.body))
        coreDataManager.saveContext()
    }

    private func deleteNote() {
        if let note = note {
            coreDataManager.managedContext.delete(note)
            coreDataManager.saveContext()
        }
    }

    private func changeText() {
        if let attributes = currentAttibute {
            let selectedText = noteBodyTextView.selectedRange
            let attributedString = NSMutableAttributedString(attributedString: noteBodyTextView.attributedText)
            attributedString.addAttributes(attributes, range: noteBodyTextView.selectedRange)
            if !underlineBotton.isSelected {
                attributedString.removeAttribute(.underlineStyle, range: noteBodyTextView.selectedRange)
            }
            noteBodyTextView.attributedText = attributedString
            noteBodyTextView.selectedRange = selectedText
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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.length == 0 && range.location == 0 && text.isEmpty {
            return true
        }

        let originalAtributedString = NSMutableAttributedString(attributedString: noteBodyTextView.attributedText)
        if range.length > 0 {
            originalAtributedString.deleteCharacters(in: range)
        } else if let attributes = currentAttibute {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
            originalAtributedString.insert(attributedString, at: range.location)
        }
        textView.attributedText = originalAtributedString
        textView.selectedRange = NSRange(location: text.isEmpty ? range.location : range.location + 1, length: 0)

        return false
    }

    private var currentAttibute: [NSAttributedString.Key: Any]? {
        if underlineBotton.isSelected {
            return [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                    NSAttributedString.Key.font: currentFont ?? UIFont()]
        } else {
            return [NSAttributedString.Key.font: currentFont ?? UIFont()]
        }
    }

    private var currentFont: UIFont? {
        let font = UIFont(name: "Times New Roman", size: 23)
        if boldButton.isSelected && italicButton.isSelected {
            return font?.boldItalics()
        } else if boldButton.isSelected {
            return font?.bold()
        } else if italicButton.isSelected {
            return font?.italics()
        } else {
            return font
        }
    }
}
