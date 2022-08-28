//
//  Persistence.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import CoreData
import SwiftUI

class PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.viewContext
        for i in 0..<3 {
            let newList = CDList(context: viewContext)
            newList.id = UUID()
            newList.title = "List #\(i)"
            newList.order = Int64(i)
            
            let newIcon = CDIcon(context: viewContext)
            newIcon.name = Icons.iconNames.randomElement()!
            newIcon.colorName = Color.projectColors.listIconColors.randomElement()!.name
            newIcon.isEmoji = false
            
            newList.icon = newIcon
            
            for i in 0..<2 {
                let newTask = CDTask(context: viewContext)
                newTask.id = UUID()
                newTask.text = "Task #\(i)"
                newTask.order = Int64(i)
                newTask.isCompleted = false
                
                newList.addToTasks(newTask)
                newList.uncompletedTaskCount += Int64(1)
            }
        }
        result.save()
        return result
    }()

    private(set) var container: NSPersistentCloudKitContainer!
    var viewContext: NSManagedObjectContext {
        get {
            return container.viewContext
        }
    }
    
    private var inMemory: Bool = false

    private init(inMemory: Bool = false) {
        self.inMemory = inMemory
        let settings = KeyValueStore.shared.getSettings()
        print("iCloud Sync: \(settings.isicloudSyncOn)")
        container = setupContainer(withSync: settings.isicloudSyncOn, inMemory: inMemory)
    }
    
    ///  Initiates container with iCloud Sync on or off
    func enableiCloudSync(_ iCloudSync: Bool) {
        print("iCloud Sync: \(iCloudSync)")
        container = setupContainer(withSync: iCloudSync, inMemory: inMemory)
    }
    
    private func setupContainer(withSync iCloudSync: Bool, inMemory: Bool) -> NSPersistentCloudKitContainer {
        let container = NSPersistentCloudKitContainer(name: "CloudKitTodo")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("[PersistenceController] OH DAM! No persistent store description! ")
        }
        if inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
        }
        
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        
        if !iCloudSync {
            description.cloudKitContainerOptions = nil
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                // MARK: Remove for shipping
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                // MARK: Remove for shipping
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func fetchLists() -> [CDList] {
        let fetchRequest = CDList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \CDList.order, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try viewContext.fetch(fetchRequest)
        }
        catch {
            print("Fetch List Error: \(error)")
            return []
        }
    }
}
