//
//  Task+CoreDataProperties.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/07/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var order: Int64
    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var list: List?

}

extension Task : Identifiable {

}
