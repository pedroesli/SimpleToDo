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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.lists) { list in
                    ListCell(list: list)
                        .onDrag {
                            return NSItemProvider()
                        }
                }
                .onDelete(perform: viewModel.deleteItem)
                .onMove(perform: viewModel.moveItem)
                .id(UUID())
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentSettingsSheet = true
                    } label: {
                        Image(systemName: "gearshape.fill")
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
            }
            .sheet(isPresented: $presentSettingsSheet) {
                SettingsView()
            }
        }
        .onAppear(perform: viewModel.onViewAppear)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
