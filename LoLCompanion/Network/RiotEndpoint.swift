//
//  RiotEndpoint.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

enum RiotEndpoint {    
    case getSummonerName(_ summonerName: String)
    case getMatches(puuId: String)
    case getMatchInfo(matchId: String)
    case getRankedStatus(summonerId: String)
}

extension RiotEndpoint: Endpoint {
    var host: String {
        switch self {
        case .getSummonerName, .getRankedStatus:
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
        case .getRankedStatus(let summonerId):
            return "/lol/league/v4/entries/by-summoner/\(summonerId)"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var header: [String : String]? {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else { return nil }
        return ["X-Riot-Token": apiKey]
    }

    var body: [String : String]? {
        return nil
    }

    var urlQueryItems: [URLQueryItem]? {
        switch self {
        case .getMatches:
            return [URLQueryItem(name: "start", value: "0"), URLQueryItem(name: "count", value: "10")]
        default:
            return nil
        }
    }
}
