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
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some View {
        NavigationView {
            Form {
                //MARK: General Section
                Section("General") {
                    Picker(selection: $selectedAppearance) {
                        Group {
                            Text("Automatic").tag(1)
                            Text("Light").tag(2)
                            Text("Dark").tag(3)
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
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        NavigationView {
            SettingsView()   
        }
        .preferredColorScheme(settingsManager.settings.colorScheme)
        .environmentObject(settingsManager)
    }
}
