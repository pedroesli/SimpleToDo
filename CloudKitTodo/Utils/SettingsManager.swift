//
//  SettingsManager.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI

class SettingsManager: ObservableObject {
    @Published var settings: Settings = KeyStore.shared.getSettings() {
        didSet {
            KeyStore.shared.storeSettings(settings)
        }
    }
    
    func getSelectedAppearance() -> Int {
        switch(settings.colorScheme) {
        case .none: return 1
        case .light: return 2
        case .dark: return 3
        default: return 1
        }
    }
    
    func setSelectedAppearance(_ selectedAppearance: Int) {
        switch(selectedAppearance) {
        case 1: settings.colorScheme = .none
        case 2: settings.colorScheme = .light
        case 3: settings.colorScheme = .dark
        default: settings.colorScheme = .none
        }
    }
}
