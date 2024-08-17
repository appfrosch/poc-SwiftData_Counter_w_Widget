//
//  poc_SwiftData_Counter_w_WidgetApp.swift
//  poc-SwiftData_Counter_w_Widget
//
//  Created by Andreas Seeger on 17.08.2024.
//

import SwiftUI
import SwiftData

@main
struct poc_SwiftData_Counter_w_WidgetApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
