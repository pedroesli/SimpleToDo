//
//  KeyStore.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 17/08/22.
//

import Foundation

struct KeyStore {
    
    static let shared = KeyStore()
    
    private let store = NSUbiquitousKeyValueStore.default
    private let emojiStoreKey = "KeyRecentEmojies"
    private let settingsStoreKey = "KeySettings"
    
    private init() { }
    
    func storeEmojiList(_ emojies: [String]) {
        store.set(emojies, forKey: emojiStoreKey)
        store.synchronize()
        
        
    }
    
    /*
        Returns the stored list of emojies, if there isnt any, a default emoji list will be created
     */
    func getEmojiList() -> [String] {
        if let emojies = store.array(forKey: emojiStoreKey) as? [String] {
            return emojies
        }
        
        let defaultEmojies = ["😀","🥳","❤️","🎁","🛍"]
        storeEmojiList(defaultEmojies)
        return defaultEmojies
    }
    
    func storeSettings(_ settings: Settings) {
        store.set(settings, forKey: settingsStoreKey)
        store.synchronize()
    }
    
    func getSettings() -> Settings {
        if let settings = store.object(forKey: settingsStoreKey) as? Settings {
            return settings
        }
        
        let defaultSettings = Settings()
        storeSettings(defaultSettings)
        return Settings()
    }
}
