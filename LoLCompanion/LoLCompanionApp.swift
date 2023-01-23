//
//  LoLCompanionApp.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import SwiftUI

@main
struct LoLCompanionApp: App {
//    @StateObject var lolManager = LoLManager()
    @StateObject var processWatcher = ProcessWatcher()


    var body: some Scene {
        MenuBarExtra("LoLCompanionApp", systemImage: "figure.yoga") {
            ContentView()
                .environmentObject(processWatcher)
////            Divider()
//            SummonerView(viewModel: SummonerViewViewModel())
//                .environmentObject(lolManager)
//            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}


