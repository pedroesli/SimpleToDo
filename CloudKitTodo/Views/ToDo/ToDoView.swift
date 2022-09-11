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
            //ToDoViewCell(task: list.tasks?.allObjects.first as! CDTask)
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
        .preferredColorScheme(.dark)
        .navigationViewStyle(.stack)
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.roundedLargeTitle]
            UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.roundedTitle]
        }
    }
}

struct ToDoCellView: View {
    
    @ObservedObject var task: CDTask
    var listTintColor: Color {
        Color(task.list?.icon?.colorName ?? "AccentColor")
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color(uiColor: .tertiarySystemBackground))
            HStack {
                Label {
                    TextField("", text: $task.text)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.projectColors.textColors.textColor)
                        .padding(EdgeInsets(top: 20, leading: 4, bottom: 20, trailing: 0))
                        .onTapGesture {
                            print("Tapped on textfield")
                        }
                } icon: {
                    Button {
                        print("Press1")
                    } label: {
                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(uiColor: .systemGroupedBackground))
                    }
                }
                .padding(.leading, 15)
                Button {
                    
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundColor(listTintColor)
                        .frame(maxHeight: .infinity)
                }
                .padding(.trailing, 15)
            }
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
