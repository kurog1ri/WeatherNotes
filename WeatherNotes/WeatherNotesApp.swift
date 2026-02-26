//
//  WeatherNotesApp.swift
//  WeatherNotes
//
//  Created by   Kosenko Mykola on 26.02.2026.
//

import SwiftUI

@main
struct WeatherNotesApp: App {

    @AppStorage("colorScheme") private var colorSchemePreference: String = "system"

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(resolvedColorScheme)
        }
    }

    private var resolvedColorScheme: ColorScheme? {
        switch colorSchemePreference {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
}
