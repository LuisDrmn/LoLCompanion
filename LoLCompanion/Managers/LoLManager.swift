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
    var matchesInfo: [MatchInfo] = []
    @Published var lastGames: [GameResume] = []

    @Published var rankedStatus: [RankedStatus] = []

    init() {
    }

    func getData() async {
        guard !matches.isEmpty else { return }
        self.lastGames = []
        for match in matches {
            if let data = await fetchMatchInfo(match) {
                for participant in data.info.participants {
                    guard participant.summonerName == remoteSummoner?.name else {
                        continue
                    }
                    lastGames.append(GameResume(id: data.info.gameID, championName: participant.championName, win: participant.win, kills: participant.kills, deaths: participant.deaths, assits: participant.assists, queueID: data.info.queueID))
                }
            }
        }
    }
}
