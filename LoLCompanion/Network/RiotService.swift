//
//  RiotService.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

typealias MatchesID = [String]

protocol RiotServiceable {
    var region: RiotRegion? { get set }

    func getSummonerName(_ summonerName: String) async -> Result<Summoner, RequestError>
    func getMatches(for summonerPuuid: String) async -> Result<MatchesID, RequestError>
    func getMatchInfo(for matchId: String) async -> Result<MatchInfo, RequestError>
    func getRankedStatus(for summonerId: String) async -> Result<[RankedStatus], RequestError>
}

struct RiotService: HTTPClient, RiotServiceable {
    var region: RiotRegion?

    func getRankedStatus(for summonerId: String) async -> Result<[RankedStatus], RequestError> {
        guard let region = region else { return .failure(.invalidRegion) }


        return await sendRequest(endpoint: RiotEndpoint.getRankedStatus(summonerId: summonerId, region), responseModel: [RankedStatus].self)
    }

    func getSummonerName(_ summonerName: String) async -> Result<Summoner, RequestError> {
        guard let region = region else { return .failure(.invalidRegion) }

        return await sendRequest(endpoint: RiotEndpoint.getSummonerName(summonerName, region), responseModel: Summoner.self)
    }

    func getMatches(for summonerPuuid: String) async -> Result<MatchesID, RequestError> {
        guard let region = region else { return .failure(.invalidRegion) }

        return await sendRequest(endpoint: RiotEndpoint.getMatches(puuId: summonerPuuid, region), responseModel: MatchesID.self)
    }

    func getMatchInfo(for matchId: String) async -> Result<MatchInfo, RequestError> {
        guard let region = region else { return .failure(.invalidRegion) }

        return await sendRequest(endpoint: RiotEndpoint.getMatchInfo(matchId: matchId, region), responseModel: MatchInfo.self)
    }
}
