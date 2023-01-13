//
//  HomeNotesViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit
import CoreData

class HomeNotesViewController: UIViewController {

    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func tappedAddButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "AddNoteScreen", identifier: "AddNoteScreen")
        navigationController?.pushViewController(controller, animated: true)
    }

    private func getNotes() {
        let noteFetch: NSFetchRequest<Note> = Note.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Note.date), ascending: false)
        noteFetch.sortDescriptors = [sortByDate]
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(noteFetch)
            notes = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}
