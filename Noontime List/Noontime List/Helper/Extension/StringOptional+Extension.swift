//
//  StringOptional+Extension.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//

import UIKit

extension Optional where Wrapped == String {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
