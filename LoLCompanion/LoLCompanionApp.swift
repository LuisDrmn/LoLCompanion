//
//  LoLCompanionApp.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import SwiftUI

@main
struct LoLCompanionApp: App {
    @StateObject var lolManager = LoLManager()

    @State var summoner: Summoner? = nil

    var body: some Scene {
        MenuBarExtra("LoLCompanionApp", systemImage: "figure.yoga") {
            ContentView()
            Divider()
            SummonerView(summoner: lolManager.findUsername())
            Button("Force update of local data") {
                self.summoner = lolManager.findUsername()
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}


