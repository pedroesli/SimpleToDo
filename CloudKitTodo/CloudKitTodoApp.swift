//
//  CloudKitTodoApp.swift
//  CloudKitTodo
//
//  Created by Pedro Ésli Vieira do Nascimento on 26/07/22.
//

import SwiftUI

@main
struct CloudKitTodoApp: App {

    let settingsManager = SettingsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.none)
                .environmentObject(settingsManager)
        }
    }
}
