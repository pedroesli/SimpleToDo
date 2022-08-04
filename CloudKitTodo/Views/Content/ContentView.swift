//
//  ContentView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
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

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var presentNewListSheet = false

    var body: some View {
        NavigationView {
            List {
                AllCell(uncompletedTaskCount: $viewModel.totalUncompletedTaskCount)
                ForEach(viewModel.lists) { list in
                    ListCell(list: list)
                }
                .onDelete(perform: viewModel.deleteItems)
                .id(UUID())
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentNewListSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New List")
                        }
                        .font(.system(.body, design: .rounded).bold())
                        .foregroundColor(.accentColor)
                    }

                }
            }
            .sheet(isPresented: $presentNewListSheet) {
                NewListView(completionHandler: viewModel.addItem(list:))
            }
        }
        .onAppear(perform: viewModel.onViewAppear)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
