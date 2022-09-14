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
            ListView()
                .preferredColorScheme(settingsManager.settings.preferredColorScheme)
                .environmentObject(settingsManager)
                .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.roundedLargeTitle]
                    UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.roundedTitle]
                    UITextView.appearance().isScrollEnabled = false
                }
        }
    }
}
