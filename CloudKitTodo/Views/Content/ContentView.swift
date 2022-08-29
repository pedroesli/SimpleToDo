//
//  ContentView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var presentNewListSheet = false
    @State private var presentSettingsSheet = false
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
                        presentSettingsSheet = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentNewListSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New List")
                        }
                        .font(.system(.body, design: .rounded).bold())
                    }

                }
            }
            .sheet(isPresented: $presentNewListSheet) {
                NewListView(completionHandler: viewModel.addItem(list:))
                    .preferredColorScheme(settingsManager.settings.preferredColorScheme ?? systemColorScheme)
            }
            .sheet(isPresented: $presentSettingsSheet) {
                SettingsView()
                    .preferredColorScheme(settingsManager.settings.preferredColorScheme ?? systemColorScheme)
            }
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
