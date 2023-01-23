//
//  ContentView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import SwiftUI

class ContentViewModel {
    var processData: [LolProcesses: Bool] = [:]

    func update(with processWatcher: ProcessWatcher) {
        for process in LolProcesses.allCases {
            let isRunning = processWatcher.isRunning(process: process)
            processData[process] = isRunning
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var processWatcher: ProcessWatcher

    var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            ForEach(LolProcesses.allCases, id: \.id) { process in
                HStack {
                    Text(process.name)
                        .foregroundColor(viewModel.processData[process] ?? false ? .green : .red)
//                    Image(systemName: viewModel.processData[process] ?? false ? "checkmark" : "xmark.circle")
                }
            }
        }.task {
            print("ONAppear")
            viewModel.update(with: processWatcher)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

