//
//  SummonerView.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import SwiftUI

class SummonerViewViewModel: ObservableObject {
}

struct SummonerView: View {
    @EnvironmentObject var lolManager: LoLManager
    @ObservedObject var viewModel: SummonerViewViewModel = SummonerViewViewModel()

    var body: some View {
        VStack {
            Text("User Local Data")
            if let localSummoner = lolManager.localSummoner {
                comonUserDateView(for: localSummoner)
            }
            Divider()
            Text("User Remote Data")
            if let remoteSummoner = lolManager.remoteSummoner {
                comonUserDateView(for: remoteSummoner)

                if let profileIconId = remoteSummoner.profileIconID,
                   let revisionDate = remoteSummoner.revisionDate,
                    let summonerLevel = remoteSummoner.summonerLevel {
                    Text("Profile Icon ID: \(profileIconId)")
                    Text("Revision Date: \(revisionDate)")
                    Text("Summoner Level: \(summonerLevel)")
                }
            }

            Button("Force Update User Data") {
                Task {
                    await lolManager.updateRemoteSummoner()
                }
            }
        }
    }

    func comonUserDateView(for summoner: Summoner) -> some View {
        VStack {
            Text("ID: \(summoner.id)")
            Text("Account ID: \(summoner.accountID)")
            Text("PUUID: \(summoner.puuid)")
                .onTapGesture {
                    print(summoner.puuid)
                    NSPasteboard.general.setString(summoner.puuid, forType: .string)
                }
            Text("Name: \(summoner.name)")
        }
    }
}

struct SummonerView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerView()
    }
}
