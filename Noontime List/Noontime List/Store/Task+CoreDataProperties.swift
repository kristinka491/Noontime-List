//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Vlad Birukov on 07.02.2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?

}
