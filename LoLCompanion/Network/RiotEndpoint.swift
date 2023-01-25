//
//  RiotEndpoint.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

enum RiotEndpoint {
    static let API_KEY = "RGAPI-e2c8723f-7d25-4a06-9933-100dfef633ee"
    
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
        return ["X-Riot-Token": RiotEndpoint.API_KEY]
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
