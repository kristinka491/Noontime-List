//
//  Note+CoreDataProperties.swift
//  Noontime List
//
//  Created by Vlad Birukov on 13.01.2023.
//
//

import UIKit
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var date: String?

}

extension Note : Identifiable {

}
