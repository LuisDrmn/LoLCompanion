//
//  RiotEndpoint.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation



enum RiotEndpoint {
    static let API_KEY = "RGAPI-d35ae846-96ab-4684-88ee-3a75a66081fb"
    case getSummonerName(_ summonerName: String)
    case getMatches(puuId: String)
    case getMatchInfo(matchId: String)
}

extension RiotEndpoint: Endpoint {
    var host: String {
        switch self {
        case .getSummonerName:
            return "euw1.api.riotgames.com"
        case .getMatches, .getMatchInfo:
            return "europe.api.riotgames.com"
        }
    }

    var path: String {
        switch self {
        case .getSummonerName(let summonerName):
            return "/lol/summoner/v4/summoners/by-name/\(summonerName)"
        case .getMatches(let puuId):
            return "/lol/match/v5/matches/by-puuid/\(puuId)/ids"
        case .getMatchInfo(let matchId):
            return "/lol/match/v5/matches/\(matchId)"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var header: [String : String]? {
        return ["X-Riot-Token": RiotEndpoint.API_KEY]
    }

    var body: [String : String]? {
        return nil
    }

    var urlQueryItems: [URLQueryItem]? {
        return nil
    }
}
