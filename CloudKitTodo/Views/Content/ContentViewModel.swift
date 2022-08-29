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
    
    private var persistenceController = PersistenceController.shared
    
    func onViewAppear() {
        lists = persistenceController.fetchLists()
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(notification:)), name: .NSManagedObjectContextDidSave, object: nil)
    }
    
    func addItem(list: CDList) {
        withAnimation {
            list.order = (lists.last?.order ?? 0) + 1
            lists.append(list)
            persistenceController.save()
        }
    }
    
    func deleteItem(list: CDList) {
        withAnimation {
            if let listIndex = lists.firstIndex(of: list) {
                lists.remove(at: listIndex)
            }
            persistenceController.viewContext.delete(list)
            persistenceController.save()
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        guard let sourceIndex = source.first else { return }
        guard sourceIndex != destination else { return }
        let listSource = lists[sourceIndex]
        let listDestination = lists[destination > sourceIndex ? destination-1 : destination]
        let listDestinationOrder = listDestination.order
        
        lists.move(fromOffsets: source, toOffset: destination)
        
        if destination > sourceIndex {
            for listItem in lists.filter({ $0.order <= listDestinationOrder }) {
                listItem.order -= 1
            }
        }
        else {
            for listItem in lists.filter({ $0.order >= listDestinationOrder }) {
                listItem.order += 1
            }
        }
        
        listSource.order = listDestinationOrder
        
        persistenceController.save()
        
        print("Swaped: \(listSource.title!)(\(listSource.order)) with: \(listDestination.title!)(\(listDestination.order))")
    }
    
    @objc private func contextDidSave(notification: Notification) {
        // Only refresh lists when there was a update on a CDList property
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
           !updatedObjects.isEmpty {
            let lists = updatedObjects.compactMap { $0 as? CDList }
            if !lists.isEmpty {
                DispatchQueue.main.async { [weak self] in
                    self?.objectWillChange.send()
                }
            }
        }
    }
    
}
