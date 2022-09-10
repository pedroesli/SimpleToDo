//
//  ListView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI
import Introspect

struct ListView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDList.order, ascending: true)])
    private var lists: FetchedResults<CDList>
    @State private var listViewSheetType: ListViewSheetType? = nil
    @EnvironmentObject private var settingsManager: SettingsManager
    @Environment(\.colorScheme) private var systemColorScheme: ColorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lists, id: \.id) { list in
                    ListCellView(list: list)
                        .onDrag {
                            return NSItemProvider()
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            SwipeButton(buttonType: .Delete) {
                                deleteItem(list: list)
                            }
                            SwipeButton(buttonType: .Edit) {
                                listViewSheetType = .newListSheet(list)
                            }
                        }
                }
                .onMove(perform: moveItem)
                //.id(UUID())
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        listViewSheetType = .settingsSheet
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        listViewSheetType = .newListSheet(nil)
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New List")
                        }
                        .font(.system(.body, design: .rounded).bold())
                    }
                }
            }
            .sheet(item: $listViewSheetType, content: { sheetType in
                Group {
                    switch sheetType {
                    case .newListSheet(let list):
                        list == nil ? NewOrEditListView() : NewOrEditListView(list: list)
                    case .settingsSheet:
                        SettingsView()
                    }
                }
                .preferredColorScheme(settingsManager.settings.preferredColorScheme ?? systemColorScheme)
            })
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack) // Must be explicitly specified for iOS to avoid tool bar bottom item visual bug
    }
    
    func deleteItem(list: CDList) {
        withAnimation {
            viewContext.delete(list)
            PersistenceController.shared.save()
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        guard let sourceIndex = source.first else { return }
        guard sourceIndex != destination else { return }
        let listSource = lists[sourceIndex]
        let listDestination = lists[destination > sourceIndex ? destination-1 : destination]
        let listDestinationOrder = listDestination.order
        
        //NOTE: Ordering algorithm needs improvement
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
        PersistenceController.shared.save()
        
        //print("Swaped: \(listSource.title!)(\(listSource.order)) with: \(listDestination.title!)(\(listDestination.order))")
        //print(lists.first?.order, lists.last?.order)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        ListView()
            .environmentObject(settingsManager)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
            .preferredColorScheme(.dark)
    }
}
