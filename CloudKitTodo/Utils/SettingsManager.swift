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
}
