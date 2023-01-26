//
//  ContentView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import SwiftUI

struct ProcessesView: View {
    @EnvironmentObject var processWatcher: ProcessWatcher

    var body: some View {
        VStack {
            Text("Processes:")
            ForEach(LolProcesses.allCases, id: \.id) { process in
                HStack {
                    Text(" - \(process.name)")
                        .foregroundColor(processWatcher.lolProcesses[process] ?? false ? .green : .red)
                }
            }
        }
    }
}

struct ProcessesView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessesView()
    }
}

