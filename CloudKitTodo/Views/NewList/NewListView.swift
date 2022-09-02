//
//  NewListView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/07/22.
//

import SwiftUI

struct NewListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var iconName = "circle"
    @State private var iconColor: ListIconColor = Color.projectColors.listIconColors[0]
    @State private var isEmoji = false
    
    var completionHandler: ((CDList) -> Void)?
    var list: CDList?
    
    var body: some View {
        NavigationView {
            List {
                TitleAndIconSection(
                    title: $title,
                    iconName: $iconName,
                    iconColor: $iconColor,
                    isEmoji: $isEmoji
                )
                ColorSelectSection(iconColor: $iconColor)
                Section {
                    EmojiSelection(iconName: $iconName, isEmoji: $isEmoji)
                    IconSelection(iconName: $iconName, isEmoji: $isEmoji)
                }
                .buttonStyle(PlainButtonStyle())
                .listRowSeparator(.hidden)
            }
            .listRowSeparator(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: createList) {
                        Text("OK")
                            .font(.body.bold())
                    }
                    .disabled(title.isEmpty)
                }
            }
            .onAppear {
                configureView()
            }
        }
    }
    
    func createList() {
        if let list = list {
            list.title = title
            list.icon?.name = iconName
            list.icon?.colorName = iconColor.name
            list.icon?.isEmoji = isEmoji
            PersistenceController.shared.save()
            dismiss()
        }
        else {
            let newList = CDList(title: title, iconColorName: iconColor.name, iconName: iconName, isEmoji: isEmoji)
            dismiss()
            completionHandler?(newList)
        }
    }
    
    /// Configure View for edit mode
    func configureView() {
        guard let list = self.list else { return }
        
        title = list.title ?? ""
        iconName = list.icon?.name ?? "circle"
        iconColor = ListIconColor(name: list.icon?.colorName ?? ListIconColor.colors.first!.name)
        isEmoji = list.icon?.isEmoji ?? false
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView(completionHandler: { list in
            
        })
    }
}

// For toolbar options
//    .toolbar {
//        ToolbarItem(placement: .navigationBarLeading) {
//            Text("New List")
//                .font(.system(size: 24))
//                .foregroundColor(.accentColor)
//        }
//        ToolbarItem(placement: .navigationBarTrailing) {
//            Button(action: dismiss.callAsFunction) {
//                Image(systemName: "xmark.square.fill")
//                    .symbolRenderingMode(.palette)
//                    .foregroundStyle(.gray, .quaternary)
//                    .font(.system(size: 24))
//            }
//        }
//    }


