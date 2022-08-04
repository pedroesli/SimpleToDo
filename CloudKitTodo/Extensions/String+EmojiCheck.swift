//
//  String+EmojiCheck.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/22.
//
//  Solution From:
//  https://betterprogramming.pub/understanding-swift-strings-characters-and-scalars-a4b82f2d8fde

import Foundation

extension Character {
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else {
          return false
        }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
}

extension String {
    
    var containsOnlyEmoji: Bool {
        return !isEmpty && !contains { !$0.isSimpleEmoji }
      }
    
}
