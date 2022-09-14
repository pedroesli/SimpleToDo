//
//  ToDoView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/09/22.
//

import SwiftUI

struct ToDoView: View {
    
    @ObservedObject var list: CDList
    @State private var tasks: [CDTask] = []
    
    var listTintColor: Color {
        Color(list.icon?.colorName ?? "AccentColor")
    }
    
    var body: some View {
        List{
            ForEach(tasks, id: \.id ) { task in
                ToDoCellView(task: task)
                    .swipeActions {
                        SwipeButton(buttonType: .Delete) {
                            
                        }
                    }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(list.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Task")
                    }
                    .font(.system(.body, design: .rounded).bold())
                }
                .tint(listTintColor)
                Spacer()
            }
        }
        .onAppear {
            tasks = list.tasks?.allObjects as? [CDTask] ?? []
        }
    }
    
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let list = PersistenceController.preview.fetchLists().first!
            ToDoView(list: list)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.roundedLargeTitle]
            UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.roundedTitle]
        }
    }
}

struct ToDoCellView: View {
    
    @ObservedObject var task: CDTask
    @State private var showInfoButton = false
    
    var listTintColor: Color {
        Color(task.list?.icon?.colorName ?? "AccentColor")
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color(uiColor: .tertiarySystemBackground))
            HStack(alignment: .top, spacing: 10) {
                CheckButton(isChecked: $task.isCompleted, checkColor: listTintColor) {
                    
                }
                ToDoTextField(text: $task.text, isStrikethrough: $task.isCompleted, onEditingChanged: { isEditing in
                    showInfoButton = isEditing
                })
                Button {
                    
                } label: {
                    if showInfoButton {
                        Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundColor(listTintColor)
                            .padding(.leading, 5)
                    }
                }
            }
            .padding()
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
