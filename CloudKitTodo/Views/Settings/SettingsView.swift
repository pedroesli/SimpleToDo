//
//  SettingsView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI

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
                    ICloudSyncOption(isOn: $settingsManager.settings.isicloudSyncOn)
                }
                //MARK: Donate Section
                Section {
                    Label {
                        Text("Buy me a cup of Coffee")
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
            .navigationTitle(Text("Settings"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                selectedAppearance = settingsManager.getSelectedAppearanceId()
            }
            .onChange(of: selectedAppearance) { newValue in
                settingsManager.selectAppearance(newValue)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Done")
                            .font(.system(.body, design: .rounded))
                    }
                }
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
                .foregroundColor(.projectColors.textColors.textColor)
            } label: {
                Label {
                    Text("Appearance")
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
        
        private var iCloudIconName: String {
            return isOn ? "icloud" : "icloud.slash"
        }
        
        var body: some View {
            HStack {
                Label {
                    Text("iCloud Sync")
                        .foregroundColor(.projectColors.textColors.textColor)
                } icon: {
                    Image(systemName: iCloudIconName)
                        .foregroundColor(.cyan)
                }
                Toggle("", isOn: $isOn)
            }
            .padding(.vertical, 1) // To remove weird flicker on text when changing image icon
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
