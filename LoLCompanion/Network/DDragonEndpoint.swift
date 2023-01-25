//
//  DDragonEndpoint.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 24/01/2023.
//

import Foundation

enum DDragonEndpoint {
    case getVersions
    case getQeues
    case getChampionImg(championName: String, patchVersion: String)
    case getProfileIconImg(profileIcon: String, patchVersion: String)
}

extension DDragonEndpoint: Endpoint {
    var host: String {
        switch self {
        case .getVersions, .getChampionImg, .getProfileIconImg:
            return "ddragon.leagueoflegends.com"
        case .getQeues:
            return "static.developer.riotgames.com"
        }
    }


    var path: String {
        switch self {
        case .getVersions:
            return "/api/versions.json"
        case .getQeues:
            return "/docs/lol/queues.json"
        case .getChampionImg(let championName, let patchVersion):
            return "/cdn/\(patchVersion)/img/champion/\(championName).png"
        case .getProfileIconImg(let profileIcon, let patchVersion):
            return "/cdn/\(patchVersion)/img/profileicon/\(profileIcon).png"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var header: [String : String]? {
        return nil
    }

    var body: [String : String]? {
        return nil
    }

    var urlQueryItems: [URLQueryItem]? {
        return nil
    }
}
