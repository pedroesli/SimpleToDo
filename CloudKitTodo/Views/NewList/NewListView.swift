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
    @State private var isEmoji = false
    
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
                    VStack {
                        EmojiSelection(iconName: $iconName, showEmojiPicker: $showEmojiPicker, isEmoji: $isEmoji)
                        IconSelection(iconName: $iconName, isEmoji: $isEmoji)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .listRowSeparator(.hidden)
                //TODO: Create the icon selection view
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
        @Binding var isEmoji: Bool
        
        var body: some View {
            Section {
                VStack(spacing: 15) {
                    makeIconPreview(iconName, isEmoji)
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
        
        @ViewBuilder func makeIconPreview(_ iconName: String,_ isEmoji: Bool) -> some View {
            Group {
                if isEmoji {
                    Text(iconName)
                }
                else {
                    Text("\(Image(systemName: iconName))")
                }
            }
            .font(.system(size: 96, weight: .bold, design: .rounded))
            .foregroundColor(iconColor.color)
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
    
    private struct IconSelection: View {
        
        @Binding var iconName: String
        @Binding var isEmoji: Bool
        private let columns = [
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17)
        ]
        
        var body: some View {
            LazyVGrid(columns: columns, alignment: .center, spacing: 17) {
                ForEach(Icons.iconNames, id: \.self) { iconName in
                    Button {
                        self.iconName = iconName
                        if isEmoji {
                            isEmoji = false
                        }
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
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(Color(uiColor: .darkGray))
                        }
                    }
                }
            }
            .padding(.bottom, 17)
        }
    }
    
    private struct EmojiSelection: View {
        
        @Binding var iconName: String
        @Binding var showEmojiPicker: Bool
        @Binding var isEmoji: Bool
        @State private var recentEmojies: [String] = ["😀","🥳","❤️","🎁","🛍"]
        private let storeKey = "KeyRecentEmojies"
        
        private let colums = [
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
            GridItem(.flexible(), spacing: 17),
        ]
        
        var body: some View {
            LazyVGrid(columns: colums, alignment: .center, spacing: 17) {
                ForEach(0..<6) { index in
                    if index == 0 {
                        ZStack {
                            EmojiPicker(emoji: $iconName, showKeyboard: $showEmojiPicker)
                                .frame(width: 0, height: 0)
                            Button {
                                showEmojiPicker = true
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(.systemGray6))
                                        .aspectRatio(1/1, contentMode: .fit)
                                    Image(systemName: "face.smiling")
                                        .font(.system(.title3, design: .rounded).bold())
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    else {
                        Button {
                            iconName = recentEmojies[index-1]
                            isEmoji = true
                        } label: {
                            makeEmojiButtonLabel(index: index-1)
                        }
                    }
                }
            }
            .padding(.top, 17)
            .onAppear {
                fetchRecentEmojies()
            }
        }
        
        @ViewBuilder func makeEmojiButtonLabel(index: Int) -> some View {
            ZStack {
                Circle()
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .aspectRatio(1/1, contentMode: .fit)
                    .overlay {
                        if iconName == recentEmojies[index] {
                            Circle()
                                .stroke(Color(uiColor: .systemGray2), lineWidth: 3)
                                .padding(-5)
                        }
                    }
                Text(recentEmojies[index])
                    .font(.system(.title3))
                    .foregroundColor(Color(uiColor: .darkGray))
            }
        }
        
        func fetchRecentEmojies() {
            if let recentEmojies = NSUbiquitousKeyValueStore.default.array(forKey: storeKey) as? [String] {
                self.recentEmojies = recentEmojies
            }
            else {
                NSUbiquitousKeyValueStore.default.set(self.recentEmojies, forKey: storeKey)
                NSUbiquitousKeyValueStore.default.synchronize()
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


