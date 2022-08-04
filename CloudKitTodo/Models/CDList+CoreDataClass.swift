//
//  CDList+CoreDataClass.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/22.
//
//

import Foundation
import CoreData

@objc(CDList)
public class CDList: NSManagedObject {
    convenience init(title: String, iconColorName: String, iconName: String, isEmoji: Bool) {
        let viewContext = PersistenceController.shared.viewContext
        self.init(context: viewContext)
        
        id = UUID()
        self.title = title
        
        let icon = CDIcon(context: viewContext)
        icon.name = iconName
        icon.colorName = iconColorName
        icon.isEmoji = isEmoji
        
        self.icon = icon
    }
}
