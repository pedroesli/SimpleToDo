//
//  SettingsManager.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI
import Combine

class SettingsManager: ObservableObject {
    @Published var settings: Settings = KeyValueStore.shared.getSettings()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(settingsKeyValueStoreDidChange), name: KeyValueStore.keyValueStoreDidChangeNotification, object: nil)
        $settings
            .receive(on: RunLoop.main)
            .dropFirst()
            .map(\.isicloudSyncOn)
            .sink(receiveValue: icloudSyncChanged(isOn:))
            .store(in: &cancellables)
    }
    
    /**
        0 = System Appearance
        1 = Light Mode
        2 = Dark Mode
     */
    func getSelectedAppearanceId() -> Int {
        return UIUserInterfaceStyle(settings.colorScheme).rawValue
    }
    
    /// Set the app appearance and updates the settings in the iCloud
    func selectAppearance(_ selectedAppearance: Int) {
        guard selectedAppearance != UIUserInterfaceStyle(settings.colorScheme).rawValue else { return }
        settings.colorScheme = ColorScheme(UIUserInterfaceStyle(rawValue: selectedAppearance)!)
        saveSettings()
    }
    
    private func saveSettings() {
        KeyValueStore.shared.storeSettings(settings)
    }
    
    private func icloudSyncChanged(isOn: Bool) {
        print("Updating iCloud Syncd")
        PersistenceController.shared.enableiCloudSync(isOn)
        saveSettings()
    }
    
    // Updates current settings when the settings from another device is changed
    @objc private func settingsKeyValueStoreDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.objectWillChange.send()
            self?.settings = KeyValueStore.shared.getSettings()
        }
    }
}
