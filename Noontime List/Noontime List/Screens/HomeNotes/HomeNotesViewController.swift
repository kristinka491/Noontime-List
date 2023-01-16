//
//  HomeNotesViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit
import CoreData

class HomeNotesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let coreDataManager = CoreDataManager.shared
    private let numberOfCellsInRow = 2
    private let spaceBetweenCells = 3
    private let spaceBetwwenCollectionViewAndScreen = 40
    private var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        getNotes()
        setUpNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        view.layoutIfNeeded()
    }

    @IBAction private func tappedAddButton(_ sender: UIButton) {
        if let controller = viewController(storyboardName: "AddNoteScreen", identifier: "AddNoteScreen") as? AddNoteViewController {
            controller.setUp(with: .add)
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout

        collectionView.register(UINib(nibName: "HomeNotesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeNotesCell")
    }

    private func getNotes() {
        let noteFetch: NSFetchRequest<Note> = Note.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Note.date), ascending: false)
        noteFetch.sortDescriptors = [sortByDate]
        do {
            let results = try coreDataManager.managedContext.fetch(noteFetch)
            notes = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        collectionView.reloadData()
    }

    private func setUpNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(managedObjectContextObjectsDidChange),
                                       name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                       object: coreDataManager.managedContext)
    }

    @objc private func managedObjectContextObjectsDidChange(notification: NSNotification) {
        getNotes()
    }
}

// MARK: -
// MARK: UICollectionViewDelegate

extension HomeNotesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeNotesCell", for: indexPath) as? HomeNotesCollectionViewCell {
            cell.setUpCell(notes[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let controller = viewController(storyboardName: "AddNoteScreen", identifier: "AddNoteScreen") as? AddNoteViewController {
            controller.setUp(with: notes[indexPath.row], typeOfController: .edit)
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Int(UIScreen.main.bounds.width) - spaceBetwwenCollectionViewAndScreen - spaceBetweenCells * (numberOfCellsInRow + 1)) / numberOfCellsInRow
        return CGSize(width: cellWidth, height: 200)
    }
}
