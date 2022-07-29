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
    
    func onViewAppear() {
        
    }
    
    func addItem() {
        withAnimation {
            
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.tintColor]
    }

    var body: some View {
        NavigationView {
            List {
                ListCell(iconName: "square", title: "square", taskCountText: "12")
//                ForEach(viewModel.lists) { list in
//                    Text(list.title ?? "No Title")
//                }
//                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationTitle("Lists")
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

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
