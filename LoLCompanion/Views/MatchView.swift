//
//  MatchView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import SwiftUI

struct MatchView: View {
    var gameResume: GameResume

    var body: some View {
        HStack {

            AsyncImage(url: DDragonManager.shared.getChampionURL(for: gameResume.championName,
                                                                 patchVersions: DDragonManager.shared.lastVersion ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(100)
                    .padding(.trailing, 16)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(gameResume.win ? "VICTORY" : "DEFEAT")
                    .foregroundColor(gameResume.win ? LoLCompanionColors.victory.swiftUI : LoLCompanionColors.defeat.swiftUI)
                    .font(Font.system(size: 16))
                    .fontWeight(.bold)
                Text("Ranked Flex")
                    .font(Font.system(size: 14))
                    .fontWeight(.regular)
            }
            Spacer()
        }
        .padding(16)
        .frame(width: 200, height: 40, alignment: .center)
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MatchView(gameResume: GameResume(id: 8, championName: "Shaco", win: true))
            MatchView(gameResume: GameResume(id: 4, championName: "Shaco", win: false))
        }
    }
}
