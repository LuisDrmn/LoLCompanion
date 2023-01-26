//
//  LoLCompanionApp.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import SwiftUI

@main
struct LoLCompanionApp: App {
    @StateObject var processWatcher = ProcessWatcher()
    
    var body: some Scene {
        Settings {
            SettingsView()
        }
        MenuBarExtra("LoLCompanionApp", image: "toolbarIcon") {
            ProcessesView()
                .environmentObject(processWatcher)
            Divider()
            Button("Settings") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }.menuBarExtraStyle(.menu)
    }
}


struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}

struct GeneralSettingsView: View {
    var body: some View {
        Text("Settings")
    }
}
