//
//  CDList+CoreDataProperties.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/22.
//
//

import Foundation
import CoreData
import SwiftUI


extension CDList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDList> {
        return NSFetchRequest<CDList>(entityName: "CDList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var order: Int64
    @NSManaged public var title: String
    @NSManaged public var uncompletedTaskCount: Int64
    @NSManaged public var tasks: NSSet?
    @NSManaged public var icon: CDIcon?

}

// MARK: Generated accessors for tasks
extension CDList {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: CDTask)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: CDTask)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension CDList : Identifiable {

}
