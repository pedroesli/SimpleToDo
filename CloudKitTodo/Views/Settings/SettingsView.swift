//
//  SettingsView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI
import Introspect

struct SettingsView: View {
    
    @State private var selectedAppearance = 1
    @EnvironmentObject private var settingsManager: SettingsManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                //MARK: General Section
                Section("General") {
                    AppearanceOption(selectedAppearance: $selectedAppearance)
                    SettingsSyncOption()
                    // Add in a future update.
                    // Not working properly as intended. 
                    //ICloudSyncOption(isOn: $settingsManager.settings.isiCloudSyncOn)
                }
                //MARK: Donate Section
                Section {
                    Label {
                        Text("Buy me a cup of Coffee")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.projectColors.textColors.textColor)
                    } icon: {
                        Image(systemName: "cup.and.saucer.fill")
                            .foregroundColor(.pink)
                    }
                } header: {
                    Text("Support")
                } footer: {
                    Text("Consider supporting the developer")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                selectedAppearance = settingsManager.getSelectedAppearanceId()
            }
            .onChange(of: selectedAppearance) { newValue in
                settingsManager.selectAppearance(newValue)
            }
            .onChange(of: settingsManager.settings.preferredColorScheme) { _ in
                selectedAppearance = settingsManager.getSelectedAppearanceId()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Done")
                            .font(.system(.body, design: .rounded))
                    }
                }
            }
            .introspectNavigationController { navigationController in
                navigationController.navigationBar.titleTextAttributes = [.font: UIFont.roundedTitle]
            }
        }
    }
    
    
    private struct AppearanceOption: View {
        @Binding var selectedAppearance: Int
        @EnvironmentObject private var settingsManager: SettingsManager
        
        var body: some View {
            Picker(selection: $selectedAppearance) {
                Group {
                    Text("Automatic").tag(0)
                    Text("Light").tag(1)
                    Text("Dark").tag(2)
                }
                .font(.system(.body, design: .rounded))
                .foregroundColor(.projectColors.textColors.textColor)
            } label: {
                Label {
                    Text("Appearance")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.projectColors.textColors.textColor)
                } icon: {
                    Image(systemName: "rectangle.fill.on.rectangle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private struct ICloudSyncOption: View {
        @Binding var isOn: Bool
        @EnvironmentObject private var settingsManager: SettingsManager
        
        private var iCloudIconName: String {
            return isOn ? "icloud" : "icloud.slash"
        }
        
        var body: some View {
            HStack {
                Label {
                    Text("iCloud Sync")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.projectColors.textColors.textColor)
                } icon: {
                    Image(systemName: iCloudIconName)
                        .foregroundColor(.cyan)
                }
                Toggle("", isOn: $isOn)
            }
            .padding(.vertical, 1) // To remove weird flicker on text when changing image icon
            .onChange(of: isOn) { newValue in
                settingsManager.icloudSyncChanged(isOn: newValue)
            }
        }
    }
    
    private struct SettingsSyncOption: View {
        
        @State private var isOn = KeyValueStore.shared.isSettingsStoreSyncEnabled
        @EnvironmentObject private var settingsManager: SettingsManager
        
        var body: some View {
            HStack {
                Label {
                    Text("Settings Sync")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.projectColors.textColors.textColor)
                } icon: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.purple)
                }
                Toggle("", isOn: $isOn)
            }
            .onChange(of: isOn) { newValue in
                settingsManager.settingsSyncChanged(isOn: newValue)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(settingsManager.settings.preferredColorScheme)
            .environmentObject(settingsManager)
    }
}



