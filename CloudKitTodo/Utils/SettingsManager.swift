//
//  SettingsManager.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI

class SettingsManager: ObservableObject {
    @Published var settings: Settings = KeyValueStore.shared.getSettings()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(settingsKeyValueStoreDidChange), name: KeyValueStore.keyValueStoreDidChangeNotification, object: nil)
    }
    
    /*
        1 = System Appearance
        2 = Light Mode
        3 = Dark Mode
     */
    func getSelectedAppearance() -> Int {
        switch(settings.colorScheme) {
        case .none: return 1
        case .light: return 2
        case .dark: return 3
        default: return 1
        }
    }
    
    /*
        Set the app appearance and updates the settings in the iCloud
     */
    func setSelectedAppearance(_ selectedAppearance: Int) {
        switch(selectedAppearance) {
        case 1: settings.colorScheme = .none
        case 2: settings.colorScheme = .light
        case 3: settings.colorScheme = .dark
        default: settings.colorScheme = .none
        }
        
        KeyValueStore.shared.storeSettings(settings)
    }
    
    @objc private func settingsKeyValueStoreDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.settings = KeyValueStore.shared.getSettings()
        }
    }
}
