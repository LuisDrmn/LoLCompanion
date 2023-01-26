//
//  RiotEndpoint.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

enum RiotEndpoint {
    case getSummonerName(_ summonerName: String, _ region: RiotRegion)
    case getMatches(puuId: String, _ region: RiotRegion)
    case getMatchInfo(matchId: String, _ region: RiotRegion)
    case getRankedStatus(summonerId: String, _ region: RiotRegion)
}

extension RiotEndpoint: Endpoint {
    
    var host: String {
        switch self {
        case .getSummonerName(_, let region), .getRankedStatus( _, let region):
            return region.platformRouting
        case .getMatches(_, let region), .getMatchInfo(_, let region):
            return region.regionalRouting
        }
    }

    var path: String {
        switch self {
        case .getSummonerName(let summonerName, _):
            return "/lol/summoner/v4/summoners/by-name/\(summonerName)"
        case .getMatches(let puuId, _):
            return "/lol/match/v5/matches/by-puuid/\(puuId)/ids"
        case .getMatchInfo(let matchId, _):
            return "/lol/match/v5/matches/\(matchId)"
        case .getRankedStatus(let summonerId, _):
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
