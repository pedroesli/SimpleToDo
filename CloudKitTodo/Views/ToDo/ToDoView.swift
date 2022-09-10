//
//  ToDoView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/09/22.
//

import SwiftUI

struct ToDoView: View {
    
    @ObservedObject var list: CDList
    
    var body: some View {
        List{
            ZStack{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(Color(uiColor: .tertiarySystemBackground))
                HStack {
                    Label {
                        Text(list.title)
                            .foregroundColor(.projectColors.textColors.textColor)
                    } icon: {
                        Button {
                            print("Press1")
                        } label: {
                            RoundedRectangle(cornerRadius: 9, style: .continuous)
                                .frame(width: 30, height: 30)
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
                Spacer()
            }
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
