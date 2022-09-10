//
//  ToDoView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/09/22.
//

import SwiftUI

class ToDoViewModel: ObservableObject {
    
    @Published var list: CDList
    
    init(list: CDList) {
        self.list = list
    }
    
    var viewTint: Color {
        Color(list.icon?.colorName ?? "AccentColor")
    }
    
    func onViewApear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Dispatch")
            self.setTitle("Hey 2")
            
        }
    }
    
    func setTitle(_ title: String) {
        self.list.title = title
        PersistenceController.shared.save()
        self.objectWillChange.send()
    }
    
    func getTitle() -> String {
        return list.title
    }
    
}

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
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(list.title)
        .toolbar {
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
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
