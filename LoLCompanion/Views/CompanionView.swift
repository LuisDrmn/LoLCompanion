//
//  CompanionView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import SwiftUI
import Combine

class CompanionViewModel: ObservableObject {
    var lolManager: LoLManager = LoLManager()
    private var scope = Set<AnyCancellable>()

    @Published var lastGames: [GameResume] = []

    init() {
        lolManager.$remoteSummoner
            .receive(on: RunLoop.main)
            .sink { _ in
                self.updateData()
            }.store(in: &scope)


        lolManager.$lastGames
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .debounce(for: 1, scheduler: RunLoop.main)
            .receive(on: RunLoop.main)
            .sink { gamesResume in
                self.lastGames = gamesResume
            }.store(in: &scope)
    }


    func updateData() {
        Task {
            await lolManager.updateLastMatches()
            await lolManager.getData()
        }
    }
}

struct CompanionView: View {
    @ObservedObject var viewModel: CompanionViewModel = CompanionViewModel()

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    SummonerView(viewModel: SummonerViewViewModel(lolManager: viewModel.lolManager))
                    Divider()
                    Text("Last Games")
                    ForEach(viewModel.lastGames, id: \.id) { game in
                        HStack {
                            Text(game.championName)
                            Text(game.win ? "Won" : "Loose")
                        }.padding(.horizontal)
                    }
                }
                Button("Force Update User Data") {
                    updateData()
                }
            }.padding(.vertical, 10)
        }.task {
            updateData()
        }
        .background(
            Color(nsColor: NSColor(red: 0.00, green: 0.04, blue: 0.07, alpha: 1.00))
        )
    }

    private func updateData() {
        viewModel.updateData()
    }
}

struct CompanionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanionView()
    }
}
