//
//  KeyStore.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 17/08/22.
//

import Foundation

class KeyValueStore {
    
    static let shared = KeyValueStore()
    static let keyValueStoreDidChangeNotification = Notification.Name(rawValue: "valuesChanged-notification")
    
    var isSettingsStoreSyncEnabled: Bool {
        get {
            if !UserDefaults.standard.itemExists(forKey: isSettingsStoreSyncEnabledKey) {
                UserDefaults.standard.set(true, forKey: isSettingsStoreSyncEnabledKey)
            }
            return UserDefaults.standard.bool(forKey: isSettingsStoreSyncEnabledKey)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: isSettingsStoreSyncEnabledKey)
            
            if newValue == true {
                // Update store with user default settings
                guard let data = UserDefaults.standard.object(forKey: settingsUserDefaultKey) as? Data,
                      let settings = try? JSONDecoder().decode(Settings.self, from: data) else { return }
                storeSettings(settings)
            }
            else {
                // Update User Default with Store Settings
                guard let data = store.data(forKey: settingsStoreKey),
                      let settings = try? JSONDecoder().decode(Settings.self, from: data) else { return }
                storeSettings(settings)
            }
        }
    }
    
    private let store = NSUbiquitousKeyValueStore.default
    private let emojiStoreKey = "KeyRecentEmojies"
    private let settingsStoreKey = "KeySettings"
    private let settingsUserDefaultKey = "KeySettingsUserDefault"
    private let isSettingsStoreSyncEnabledKey = "KeyIsSettingsStoreSyncEnabled"
    
    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ubiquitousKeyValueStoreDidChange(_:)),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: store
        )
    }
    
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
        if isSettingsStoreSyncEnabled {
            do  {
                let data = try JSONEncoder().encode(settings)
                store.set(data, forKey: settingsStoreKey)
                store.synchronize()
            }
            catch {
                print("[KeyStore] Could not store settings, error: \(error)")
            }
        }
        else {
            do {
                let data = try JSONEncoder().encode(settings)
                UserDefaults.standard.set(data, forKey: settingsUserDefaultKey)
            }
            catch {
                print("[KeyStore] Could not store settings, error: \(error)")
            }
        }
    }
    
    func getSettings() -> Settings {
        if isSettingsStoreSyncEnabled {
            if let data = store.data(forKey: settingsStoreKey),
               let settings = try? JSONDecoder().decode(Settings.self, from: data){
                return settings
            }
        }
        else {
            if let data = UserDefaults.standard.object(forKey: settingsUserDefaultKey) as? Data,
               let settings = try? JSONDecoder().decode(Settings.self, from: data){
                return settings
            }
        }
        
        let defaultSettings = Settings()
        return defaultSettings
    }
    
    /*
        Get Key Value Store notification and notify only a value changed
     */
    @objc private func ubiquitousKeyValueStoreDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let reasonForChange = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int else { return }
        
        if reasonForChange == NSUbiquitousKeyValueStoreServerChange {
            NotificationCenter.default.post(name: KeyValueStore.keyValueStoreDidChangeNotification, object: nil)
        }
        else if reasonForChange == NSUbiquitousKeyValueStoreQuotaViolationChange {
            print("[KeyStore] The app’s key-value store has exceeded its space quota on the iCloud server!")
        }
    }
}
