//
//  CDTask+CoreDataClass.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/07/22.
//
//

import Foundation
import CoreData

@objc(CDTask)
public class CDTask: NSManagedObject {
    convenience init(context: NSManagedObjectContext, text: String, order: Int) {
        self.init(context: context)
        id = UUID()
        isCompleted = false
        self.text = text
        self.order = Int64(order)
    }
}
