//
//  ContentView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var contentSheetType: ContentSheetType? = nil
    @EnvironmentObject private var settingsManager: SettingsManager
    @Environment(\.colorScheme) private var systemColorScheme: ColorScheme
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.lists, id: \.id) { list in
                    ListCell(list: list)
                        .onDrag {
                            return NSItemProvider()
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            SwipeButton(buttonType: .Delete) {
                                viewModel.deleteItem(list: list)
                            }
                            SwipeButton(buttonType: .Edit) {
                                contentSheetType = .newListSheet(list)
                            }
                        }
                }
                .onMove(perform: viewModel.moveItem)
                .id(UUID())
            }
            .navigationBarTitleDisplayMode(.inline)
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
                        if list == nil {
                            NewListView(completionHandler: viewModel.addItem(list:))
                        }
                        else {
                            NewListView(completionHandler: viewModel.addItem(list:), list: list)
                        }
                    case .settingsSheet:
                        SettingsView()
                    }
                }
                .preferredColorScheme(settingsManager.settings.preferredColorScheme ?? systemColorScheme)
            })
        }
        .onAppear(perform: viewModel.onViewAppear)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        ContentView()
            .environmentObject(settingsManager)
            .preferredColorScheme(.dark)
    }
}
