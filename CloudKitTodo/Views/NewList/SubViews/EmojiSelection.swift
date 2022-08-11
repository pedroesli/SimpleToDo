//
//  EmojiSelection.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/22.
//

import SwiftUI

struct EmojiSelection: View {
    
    @Binding var iconName: String
    @Binding var isEmoji: Bool
    @State private var recentEmojies: [String] = ["😀","🥳","❤️","🎁","🛍"]
    @State private var showEmojiPicker = false
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
                        EmojiPicker(
                            emoji: $iconName,
                            showKeyboard: $showEmojiPicker,
                            isEmoji: $isEmoji,
                            completionHandler: addRecentEmoji(emoji:)
                        )
                        .frame(width: 0, height: 0)
                        Button {
                            showEmojiPicker = true
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.projectColors.newListColors.newListBackgroundColor)
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
            getRecentEmojies()
        }
    }
    
    @ViewBuilder func makeEmojiButtonLabel(index: Int) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.projectColors.newListColors.newListBackgroundColor)
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
        }
    }
    
    func getRecentEmojies() {
        if let recentEmojies = NSUbiquitousKeyValueStore.default.array(forKey: storeKey) as? [String] {
            self.recentEmojies = recentEmojies
        }
        else {
            storeRecenteEmojies()
        }
    }
    
    func addRecentEmoji(emoji: String) {
        recentEmojies.removeLast()
        recentEmojies.insert(emoji, at: 0)
        storeRecenteEmojies()
    }
    
    func storeRecenteEmojies() {
        NSUbiquitousKeyValueStore.default.set(self.recentEmojies, forKey: storeKey)
        NSUbiquitousKeyValueStore.default.synchronize()
    }
}

//struct EmojiSelection_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiSelection()
//    }
//}
