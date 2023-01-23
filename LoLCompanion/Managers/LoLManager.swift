//
//  LoLManger.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation

class LoLManager: ObservableObject {
    var riotService = RiotService()

    @Published var localSummoner: Summoner?
    @Published var remoteSummoner: Summoner?
    @Published var matches: MatchesID = []
    @Published var matchesInfo: [MatchInfo] = []

    init() {}

    func getData() async {
        guard !matches.isEmpty else { return }
        for match in matches {
            if let data = await fetchMatchInfo(match) {
                for participant in data.info.participants {
                    print(participant.puuid)
                    print(participant.championName)
                    print(participant.summonerName)
                    print(participant.win)
                    print(participant.puuid)
                }
            }
        }
    }
}
