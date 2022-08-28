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
    @State private var presentNewListSheet = false
    @State private var presentSettingsSheet = false
    @EnvironmentObject private var settingsManager: SettingsManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.lists, id: \.id) { list in
                    ListCell(list: list)
                        .onDrag {
                            return NSItemProvider()
                        }
                }
                .onDelete(perform: viewModel.deleteItem)
                .onMove(perform: viewModel.moveItem)
                .id(UUID())
            }
            .onChange(of: viewModel.lists, perform: { newValue in
                print("Lists Changed: \(newValue)")
            })
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
                    .preferredColorScheme(settingsManager.settings.colorScheme)
            }
            .sheet(isPresented: $presentSettingsSheet) {
                SettingsView()
                    .preferredColorScheme(settingsManager.settings.colorScheme)
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
