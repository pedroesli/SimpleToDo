//
//  CDIcon+CoreDataProperties.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/22.
//
//

import Foundation
import CoreData


extension CDIcon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDIcon> {
        return NSFetchRequest<CDIcon>(entityName: "CDIcon")
    }

    @NSManaged public var colorName: String?
    @NSManaged public var name: String?
    @NSManaged public var isEmoji: Bool
    @NSManaged public var list: CDList?

}

extension CDIcon : Identifiable {

}
