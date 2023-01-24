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
                VStack(alignment: .leading) {
                    SummonerView(viewModel: SummonerViewViewModel(lolManager: viewModel.lolManager))
                    CustomDivider(color: .gold, frame: NSSize(width: 168, height: 2))
                        .padding(16)
                    Text("Last Games")
                        .font(Font.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.leading, 16)
                    ForEach(viewModel.lastGames, id: \.id) { game in
                        MatchView(gameResume: game)
                        CustomDivider(color: .grey, frame: NSSize(width: 168, height: 1))
                            .padding(16)
                    }
                }
                Button("Force Update User Data") {
                    updateData()
                }.padding(.vertical, 16)
            }.padding(.vertical, 10)
        }.task {
            updateData()
        }
        .background(
            LoLCompanionColors.background.swiftUI
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
