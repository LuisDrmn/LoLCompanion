//
//  LoLProcesses.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation

enum LolProcesses: Identifiable, CaseIterable {
    case riotClient
    case leagueClient
    case leagueClientUx
    case leagueClientUxHelper

    var id: String {
        return self.bundleIdentifier
    }

    var name: String {
        switch self {
        case .riotClient:
            return "RiotClient"
        case .leagueClient:
            return "LeagueClient"
        case .leagueClientUx:
            return "LeagueClientUx"
        case .leagueClientUxHelper:
            return "LeagueClientUxHelper"
        }
    }

    var bundleIdentifier: String {
        switch self {
        case .riotClient:
            return "com.riotgames.RiotGames.RiotClient"
        case .leagueClient:
            return "com.riotgames.LeagueofLegends.LeagueClient"
        case .leagueClientUx:
            return "com.riotgames.LeagueofLegends.LeagueClientUx"
        case .leagueClientUxHelper:
            return "com.riotgames.LeagueofLegends.LeagueClientUxHelper"
        }
    }
}
