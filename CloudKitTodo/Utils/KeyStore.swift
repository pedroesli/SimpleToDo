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
        
        // Default emojies
        return ["😀","🥳","❤️","🎁","🛍"]
    }
    
    func storeSettings(_ settings: Settings) {
        do  {
            let data = try JSONEncoder().encode(settings)
            store.set(data, forKey: settingsStoreKey)
            store.synchronize()
        }
        catch {
            print("[KeyStore] Could not store settings, error: \(error)")
        }
    }
    
    func getSettings() -> Settings {
        if let data = store.data(forKey: settingsStoreKey) {
            if let settings = try? JSONDecoder().decode(Settings.self, from: data) {
                return settings
            }
        }
        
        let defaultSettings = Settings()
        return defaultSettings
    }
}
