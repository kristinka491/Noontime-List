//
//  Date+Extension.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//

import UIKit

extension Date {

    func getStringFromDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }

    func getDateFromString(dateString: String, format: String) -> Date {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.date(from: dateString) ?? Date()
    }
}
