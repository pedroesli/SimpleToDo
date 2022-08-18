//
//  SettingsView.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/08/22.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var settingsManager: SettingsManager
    @State private var selectedAppearance = 1
    
    var body: some View {
        Form {
            //MARK: General Section
            Section("General") {
                Picker(selection: $selectedAppearance) {
                    Text("Automatic").tag(1)
                    Text("Light").tag(2)
                    Text("Dark").tag(3)
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
