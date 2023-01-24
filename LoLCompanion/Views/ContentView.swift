//
//  ContentView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import SwiftUI

class ContentViewModel {

}

struct ContentView: View {
    @EnvironmentObject var processWatcher: ProcessWatcher

    var body: some View {
        VStack {
            ForEach(LolProcesses.allCases, id: \.id) { process in
                HStack {
                    Text(process.name)
                        .foregroundColor(processWatcher.lolProcesses[process] ?? false ? .green : .red)
//                    Image(systemName: viewModel.processData[process] ?? false ? "checkmark" : "xmark.circle")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

