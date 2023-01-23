//
//  RiotService.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

typealias MatchesID = [String]
protocol RiotServiceable {
    func getSummonerName(_ summonerName: String) async -> Result<Summoner, RequestError>
    func getMatches(for summonerPuuid: String) async -> Result<MatchesID, RequestError>
    func getMatchInfo(for matchId: String) async -> Result<MatchInfo, RequestError>
}

struct RiotService: HTTPClient, RiotServiceable {
    func getSummonerName(_ summonerName: String) async -> Result<Summoner, RequestError> {
        await sendRequest(endpoint: RiotEndpoint.getSummonerName(summonerName), responseModel: Summoner.self)
    }

    func getMatches(for summonerPuuid: String) async -> Result<MatchesID, RequestError> {
        await sendRequest(endpoint: RiotEndpoint.getMatches(puuId: summonerPuuid), responseModel: MatchesID.self)
    }

    func getMatchInfo(for matchId: String) async -> Result<MatchInfo, RequestError> {
        await sendRequest(endpoint: RiotEndpoint.getMatchInfo(matchId: matchId), responseModel: MatchInfo.self)
    }
}
