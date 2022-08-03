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
    @State private var iconName = "square"
    @State private var iconColor: ListIconColor = Color.projectColors.listIconColors[4]
    @State private var showEmojiPicker = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17),
        GridItem(.flexible(), spacing: 17)
    ]
    
    var body: some View {
        NavigationView {
            List {
                TitleAndIconSection(
                    title: $title,
                    iconName: $iconName,
                    iconColor: $iconColor
                )
                ColorSelectSection(iconColor: $iconColor)
                Section {
//                    ZStack {
//                        EmojiPicker(emoji: $iconName, showKeyboard: $showEmojiPicker)
//                            .frame(width: 0, height: 0)
//                        Button {
//                            showEmojiPicker = true
//                        } label: {
//                            Image(systemName: "face.smiling")
//                                .resizable()
//                                .aspectRatio(1/1, contentMode: .fit)
//                                .frame(width: 30)
//                                .font(.body.bold())
//                                .foregroundColor(.blue)
//                                .padding(7)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                        .foregroundColor(Color(.systemGray6))
//                                }
//                        }
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    LazyVGrid(columns: columns, alignment: .center, spacing: 17) {
                        ForEach(Icons.iconNames, id: \.self) { iconName in
                            Button {
                                self.iconName = iconName
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(uiColor: .systemGray6))
                                        .aspectRatio(1/1, contentMode: .fit)
                                        .overlay {
                                            if self.iconName == iconName {
                                                Circle()
                                                    .stroke(Color(uiColor: .systemGray2), lineWidth: 3)
                                                    .padding(-5)
                                            }
                                        }
                                    Image(systemName: iconName)
                                        .font(.system(.title2, design: .rounded))
                                        .foregroundColor(Color(uiColor: .darkGray))
                                        .padding(8)
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 17)
                }
                //TODO: Create the icon selection view
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("OK")
                            .font(.body.bold())
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        
    }
    
    private struct TitleAndIconSection: View {
        
        @Binding var title: String
        @Binding var iconName: String
        @Binding var iconColor: ListIconColor
        
        var body: some View {
            Section {
                VStack(spacing: 15) {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .font(.body.bold())
                        .frame(width: 75)
                        .foregroundColor(iconColor.color)
                    //MARK: Replace with UIKit textfield in a future update
                    TextField("", text: $title,prompt: Text("List Title"))
                        .foregroundColor(iconColor.color)
                        .font(.system(.title2, design: .rounded).bold())
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color(uiColor: .systemGray6))
                        }
                }
                .padding(.vertical, 15)
            }
        }
    }
    
    private struct ColorSelectSection: View {
        
        @Binding var iconColor: ListIconColor
        private let columns = [
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17)
        ]
        
        var body: some View {
            Section {
                LazyVGrid(columns: columns, alignment: .center, spacing: 17) {
                    ForEach(Color.projectColors.listIconColors, id: \.name) { listColor in
                        ZStack {
                            Button {
                                self.iconColor = listColor
                            } label: {
                                Circle()
                                    .foregroundColor(listColor.color)
                                    .aspectRatio(1/1, contentMode: .fill)
                                    .overlay {
                                        if self.iconColor.name == listColor.name {
                                            Circle()
                                                .stroke(Color(uiColor: .systemGray2), lineWidth: 3)
                                                .padding(-5)
                                        }
                                    }
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical, 17)
            }
        }
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView()
            
            
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
