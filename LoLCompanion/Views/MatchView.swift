//
//  MatchView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import SwiftUI

struct MatchView: View {
    @EnvironmentObject var dragonManager: DDragonManager

    var gameResume: GameResume
    @State var queueName: String = "Not Found"
    var body: some View {
        HStack {
            AsyncImage(url: dragonManager.getChampionURL(for: gameResume.championName,
                                                                 patchVersions: DDragonManager.shared.lastVersion ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(100)
                    .overlay(
                        Circle()
                            .stroke(LoLCompanionColors.gold.swiftUI, lineWidth: 2)
                    )
                    .padding(.trailing, 8)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(gameResume.win ? "VICTORY" : "DEFEAT")
                    .foregroundColor(gameResume.win ? LoLCompanionColors.victory.swiftUI : LoLCompanionColors.defeat.swiftUI)
                    .font(Font.system(size: 16))
                    .fontWeight(.bold)
                Text(queueName)
                    .font(Font.system(size: 12))
                    .fontWeight(.regular)
                Text("\(String(gameResume.kills))/\(String(gameResume.deaths))/\(String(gameResume.assits))")
                    .font(Font.system(size: 14))
                    .fontWeight(.regular)
            }
            Spacer()
        }
        .padding(16)
        .frame(width: 200, height: 40, alignment: .center)
        .onAppear {
            getQueueName(for: gameResume.queueID)
        }
    }

    func getQueueName(for queueID: Int) {
        if let queues = dragonManager.queues {
            if let name = queues.first(where: {$0.queueID == queueID})?.description {
                self.queueName = name.replacingOccurrences(of: "5v5 ", with: "").replacingOccurrences(of: " games", with: "")
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MatchView(gameResume: GameResume(id: 8, championName: "Shaco", win: true, kills: 2, deaths: 4, assits: 12, queueID: 420))
            MatchView(gameResume: GameResume(id: 4, championName: "Shaco", win: false, kills: 2, deaths: 4, assits: 12, queueID: 420))
        }
    }
}
