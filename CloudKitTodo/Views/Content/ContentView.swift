//
//  ContentView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI
import Introspect

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDList.order, ascending: true)])
    private var lists: FetchedResults<CDList>
    @State private var contentSheetType: ContentSheetType? = nil
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
                                contentSheetType = .newListSheet(list)
                            }
                        }
                }
                .onMove(perform: viewModel.moveItem) // TODO: move "moveItem" func to content view
                //.id(UUID())
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        contentSheetType = .settingsSheet
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        contentSheetType = .newListSheet(nil)
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New List")
                        }
                        .font(.system(.body, design: .rounded).bold())
                    }
                }
            }
            .sheet(item: $contentSheetType, content: { sheetType in
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
            //.navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack) // Must be explicitly specified for iOS to avoid tool bar bottom item visual bug
        .onAppear(perform: viewModel.onViewAppear)
    }
    
    func deleteItem(list: CDList) {
        withAnimation {
            viewContext.delete(list)
            PersistenceController.shared.save()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        ContentView()
            .environmentObject(settingsManager)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
            .preferredColorScheme(.dark)
    }
}
