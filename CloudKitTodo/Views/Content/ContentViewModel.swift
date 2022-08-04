//
//  ContentViewModel.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/22.
//

import SwiftUI
import CoreData

class ContentViewModel: ObservableObject {
    
    @Published var lists: [CDList] = []
    @Published var totalUncompletedTaskCount = 0
    
    private var persistenceController = PersistenceController.shared
    private var notification: NSObjectProtocol?
    
    deinit {
        if let notification = notification {
            NotificationCenter.default.removeObserver(notification)
        }
    }
    
    func onViewAppear() {
        lists = persistenceController.fetchLists()
        countTotalUncompletedTaskCount()
        
        notification = NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: nil, queue: .main, using: contextDidSave(notification:))
    }
    
    func addItem(list: CDList) {
        withAnimation {
            list.order = Int64(lists.count)
            lists.append(list)
            persistenceController.save()
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets
                .map { lists[$0] }
                .forEach { list in
                    totalUncompletedTaskCount -= Int(list.uncompletedTaskCount)
                    persistenceController.viewContext.delete(list)
                }
            lists.remove(atOffsets: offsets)
            persistenceController.save()
        }
    }
    
    private func countTotalUncompletedTaskCount() {
        DispatchQueue.global(qos: .userInteractive).async {
            var count = 0
            for list in self.lists {
                count += Int(list.uncompletedTaskCount)
            }
            DispatchQueue.main.async {
                self.totalUncompletedTaskCount = count
            }
        }
    }
    
    private func contextDidSave(notification: Notification) {
        // Only refresh lists and totalUncompletedTaskCount when there was a update on a CDList property
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
           !updatedObjects.isEmpty {
            let lists = updatedObjects.compactMap { $0 as? CDList }
            if !lists.isEmpty {
                self.objectWillChange.send()
                countTotalUncompletedTaskCount()
            }
        }
    }
    
}
