//
//  ToDoView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/09/22.
//

import SwiftUI
import Introspect

class ToDoViewModel: ObservableObject {
    
    @Published var list: CDList?
    
    init(list: CDList) {
        self.list = list
    }
    
    var title: String {
        list?.title ?? ""
    }
    var viewTint: Color {
        Color(list?.icon?.colorName ?? "AccentColor")
    }
    
    func onViewApear(list: CDList) {
        self.list = list
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Dispatch")
            self.list?.title = "Hello"
        }
    }
    
}

struct ToDoView: View {
    
    @ObservedObject var viewModel: ToDoViewModel
    @EnvironmentObject private var navDelegate: NavigationControllerDelegate
    
    var body: some View {
        List{
            ZStack{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(Color(uiColor: .tertiarySystemBackground))
                HStack {
                    Label {
                        Text("Do Something")
                            .foregroundColor(.projectColors.textColors.textColor)
                    } icon: {
                        Button {
                            print("Press1")
                        } label: {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                        }
                    }
                }
            }
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowBackground(Color(uiColor: .systemGroupedBackground))
        }
        .listStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                        Text("New Task")
                    }
                    .font(.system(.body, design: .rounded).bold())
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.list?.title ??  "")
        .tint(viewModel.viewTint)
    }
    
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let list = PersistenceController.preview.fetchLists().first!
            ToDoView(viewModel: ToDoViewModel(list: list))
                .environmentObject(NavigationControllerDelegate())
        }
        .preferredColorScheme(.dark)
        .navigationViewStyle(.stack)
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.roundedLargeTitle]
            UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.roundedTitle]
        }
    }
}
