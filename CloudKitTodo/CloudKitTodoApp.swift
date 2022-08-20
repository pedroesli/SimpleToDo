//
//  CloudKitTodoApp.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI

@main
struct CloudKitTodoApp: App {

    @StateObject var settingsManager = SettingsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settingsManager)
//                .onChange(of: settingsManager.settings.colorScheme) { newValue in
//                    print("User seleted: \(newValue)")
//                }
        }
    }
}
