//
//  HomePlannerViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit
import FSCalendar
import CoreData


class HomePlannerViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    private let coreDataManager = CoreDataManager.shared

    private var selectedDate: Date?

    private var tasks = [Task]()

    private var isSelected = false {
        didSet {
            addButton.isEnabled = isSelected
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getTasks()
        setUpLabel()
        setUpCalendar()
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        view.layoutIfNeeded()
    }

    @IBAction private func tappedCalendarButton(_ sender: UIButton) {
        if calendar.scope == FSCalendarScope.month {
            calendar.scope = .week
            calendarButton.setImage(UIImage(named: "monthCalendar"), for: .normal)
        } else {
            calendar.scope = .month
            calendarButton.setImage(UIImage(named: "weekCalendar"), for: .normal)
        }
        calendar.collectionViewLayout.invalidateLayout()
    }

    @IBAction private func tappedAddButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "AddTaskScreen", bundle: nil)
        if let addTaskViewController = storyBoard.instantiateViewController(withIdentifier: "AddTaskScreen") as? AddTaskViewController {
            addTaskViewController.setUp(with: selectedDate ?? Date())
            navigationController?.pushViewController(addTaskViewController, animated: true)
        }
    }

    private func setUpLabel() {
        let date = Date()
        dateLabel.text = date.getStringFromDate(format: "EEEE, MMM d, yyyy")
    }

    private func setUpCalendar() {
        calendar.appearance.titleFont = UIFont(name: "Times New Roman", size: 17)
        calendar.appearance.weekdayFont = UIFont(name: "Times New Roman", size: 17)
        calendar.appearance.headerTitleFont = UIFont(name: "Times New Roman", size: 18)

        calendar.today = nil

        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = UIColor(red: 96/255, green: 111/255, blue: 130/255, alpha: 1.00)
        calendar.appearance.titleWeekendColor = UIColor(red: 96/255, green: 111/255, blue: 130/255, alpha: 1.00)
        calendar.appearance.selectionColor = UIColor(red: 250/255, green: 26/255, blue: 142/255, alpha: 1.00)
        calendar.appearance.eventDefaultColor = UIColor(red: 250/255, green: 26/255, blue: 142/255, alpha: 1.00)
        calendar.appearance.eventSelectionColor = .black


        calendar.placeholderType = .none
        calendar.appearance.headerMinimumDissolvedAlpha = 0

        calendar.firstWeekday = 2
    }

    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TasksTableViewCell", bundle: nil), forCellReuseIdentifier: "taskCell")
    }

    private func getTasks() {
        let taskFetch: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Task.date), ascending: false)
        taskFetch.sortDescriptors = [sortByDate]
        do {
            let results = try coreDataManager.managedContext.fetch(taskFetch)
            tasks = results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        tableView.reloadData()
    }
}

// MARK: -
// MARK: FScalendarDelegate

extension HomePlannerViewController: FSCalendarDataSource, FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let now = Date()
        let calendar = Calendar.current

        let currentDate = calendar.date(bySettingHour: calendar.component(.hour, from: now),
                               minute: calendar.component(.minute, from: now),
                               second: calendar.component(.second, from: now),
                               of: date)

        selectedDate = currentDate
        isSelected = true
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        return 1
    }
}

// MARK: -
// MARK: TableViewDelegate

extension HomePlannerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TasksTableViewCell {
            cell.setUp(tasks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}


