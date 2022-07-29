//
//  ContentView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI
import CoreData
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var lists: [CDList] = []
    @Published var totalUncompletedTaskCount = 0
    
    private var persistenceController = PersistenceController.shared
    private var cancellables =  Set<AnyCancellable>()
    
    deinit {
        cancellables.forEach{ $0.cancel() }
    }
    
    func onViewAppear() {
        lists = persistenceController.fetchLists()
        countTotalUncompletedTaskCount()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let list = self.lists.first!
            list.id = UUID()
            list.title = "New Title 16"
            self.persistenceController.save()
            
            self.lists = self.persistenceController.fetchLists()
        }
    }
    
    func addItem() {
        withAnimation {
            let newList = CDList(context: persistenceController.viewContext)
            newList.id = UUID()
            newList.title = "List #\(lists.count)"
            newList.order = Int64(lists.count)
            newList.iconName = Icons().iconNames.randomElement()!
            newList.iconColorName = Color.projectColors.listColors.colorNames.randomElement()!
            newList.uncompletedTaskCount = 0
            
            for i in 0..<2 {
                let newTask = CDTask(context: persistenceController.viewContext)
                newTask.id = UUID()
                newTask.text = "Task #\(i)"
                newTask.order = Int64(i)
                newTask.isCompleted = false
                
                newList.addToTasks(newTask)
                newList.uncompletedTaskCount += Int64(1)
            }
            
            totalUncompletedTaskCount += 2
            persistenceController.save()
            lists.append(newList)
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
        var count = 0
        for list in self.lists {
            count += Int(list.uncompletedTaskCount)
        }
        self.totalUncompletedTaskCount = count
    }
    
    func listItemChanged(list: CDList) {
        print("Changeddd: \(list)")
        //lists[index].title = list.title
    }
    
}

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            List {
                AllCell(uncompletedTaskCount: $viewModel.totalUncompletedTaskCount)
                ForEach(viewModel.lists, id: \.id) { list in
                    ListCell(list: list)
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.addItem) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New List")
                        }
                        .font(.system(.body, design: .rounded).bold())
                        .foregroundColor(.accentColor)
                    }
                }
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
