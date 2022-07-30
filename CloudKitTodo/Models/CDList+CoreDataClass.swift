//
//  CDList+CoreDataClass.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/07/22.
//
//

import Foundation
import CoreData

@objc(CDList)
public class CDList: NSManagedObject {
    convenience init(context: NSManagedObjectContext, title: String, order: Int, iconName: String, iconColorName: String) {
        self.init(context: context)
        id = UUID()
        uncompletedTaskCount = 0
        self.title = title
        self.order = Int64(order)
        self.iconName = iconName
        self.iconColorName = iconColorName
    }
}
