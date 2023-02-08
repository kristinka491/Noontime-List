//
//  Task+CoreDataClass.swift
//  
//
//  Created by Vlad Birukov on 07.02.2023.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    private static let coreDataManager = CoreDataManager.shared

    static func isDateHasEvents(date: Date) -> Bool {
        return getTasksByDate(date: date).isEmpty ? false : true
    }

    static func getTasksByDate(date: Date) -> [Task] {
        let taskFetch = Task.fetchRequest()
        taskFetch.predicate = NSPredicate(format: "date == %@", date as NSDate)

        do {
            let results = try coreDataManager.managedContext.fetch(taskFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }
}
