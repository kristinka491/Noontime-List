//
//  HomePlannerViewController.swift
//  Noontime List
//
//  Created by Vlad Birukov on 12.01.2023.
//

import UIKit
import FSCalendar


class HomePlannerViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        setUpCalendar()
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

    private func setUpLabel() {
        let date = Date()
        dateLabel.text = date.getStringFromDate(format: "MMM d")
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

        calendar.placeholderType = .none
        calendar.appearance.headerMinimumDissolvedAlpha = 0

        calendar.firstWeekday = 2
    }
}


