//
//  CompanionView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import SwiftUI

struct CompanionViewModel {

}

struct CompanionView: View {
    @ObservedObject var lolManager: LoLManager = LoLManager()

    var body: some View {
        ScrollView {
            VStack {
                SummonerView()
                    .environmentObject(lolManager)
//                Divider()
                Text("Last Games")
                ForEach(lolManager.matches, id: \.self) {
                    Text($0)
                }
            }.task {
                lolManager.updateLocalSummoner()
                await lolManager.updateRemoteSummoner()
                await lolManager.updateLastMatches()
                await lolManager.getData()
            }
        }
    }
}

struct CompanionView_Previews: PreviewProvider {
    static var previews: some View {
        CompanionView()
    }
}
