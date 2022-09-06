//
//  ToDoView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/09/22.
//

import SwiftUI
import Introspect

class ToDoViewModel: ObservableObject {
    @Published private(set) var list: CDList
    
    init(list: CDList) {
        self.list = list
    }
}

struct ToDoView: View {
    
    @StateObject var viewModel: ToDoViewModel
    @EnvironmentObject private var navDelegate: NavigationControllerDelegate
    private let defaultColorName = "AccentColor"
    
    var body: some View {
        List{
            Text("DDD")
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.list.title ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: {
                    Text("HEYE")
                }

            }
        }
        .tint(Color(viewModel.list.icon?.colorName ?? defaultColorName))
    }
    
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let list = PersistenceController.preview.fetchLists().first!
            ToDoView(viewModel: ToDoViewModel(list: list))
                .environmentObject(NavigationControllerDelegate())
        }
        .navigationViewStyle(.stack)
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.roundedLargeTitle]
            UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.roundedTitle]
        }
    }
}
