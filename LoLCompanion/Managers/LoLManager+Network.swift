//
//  LoLManager+Remote.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 23/01/2023.
//

import Foundation

extension LoLManager {
    func getRankedStatus(for summonerId: String) async {
        let result = await riotService.getRankedStatus(for: summonerId)
        switch result {
        case .success(let rankedStatus):
            self.rankedStatus = rankedStatus
        case .failure(let failure):
            print(failure.errorDescription)
        }
    }

    func fetchMatchInfo(_ matchID: String) async -> MatchInfo? {
        let result = await riotService.getMatchInfo(for: matchID)
        switch result {
        case .success(let matchInfo):
            self.matchesInfo.append(matchInfo)
            return matchInfo
        case .failure(let failure):
            print(failure.errorDescription)
            return nil
        }
    }


    // MARK: - LAST MATCHES
    func updateLastMatches() async {
        guard let remoteSummoner = self.remoteSummoner else { return }
        let result = await riotService.getMatches(for: remoteSummoner.puuid)
        switch result {
        case .success(let matches):
            self.matches = matches
        case .failure(let failure):
            print(failure.errorDescription)
            return
        }
    }


    // MARK: - REMOTE SUMMONER
    func updateRemoteSummoner() async {
        guard let localSummoner = self.localSummoner else { return }
        print("Update Remote")
        self.remoteSummoner = await findRemoteSummoner(with: localSummoner)
    }

    private func findRemoteSummoner(with localSummoner: Summoner) async -> Summoner? {
        let result = await riotService.getSummonerName(localSummoner.name)
        switch result {
        case .success(let summoner):
            return summoner
        case .failure(let failure):
            print(failure.errorDescription)
            return nil
        }
    }
}
