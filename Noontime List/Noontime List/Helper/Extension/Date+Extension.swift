//
//  Date+Extension.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//

import UIKit

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
