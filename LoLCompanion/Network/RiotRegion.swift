//
//  RiotRegions.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 26/01/2023.
//

import Foundation

// AMERICAS americas.api.riotgames.com
// ASIA     asia.api.riotgames.com
// EUROPE   europe.api.riotgames.com
// SEA      sea.api.riotgames.com

enum RiotRegion: String, CaseIterable {
    case br1, eun1, euw1, jp1, kr1, la1, la2, na1, oc1, tr1, ru, ph2, sg2, th2, tw2, vn2

    var regionalRouting: String {
        switch self {
        case .br1, .la1, .la2, .na1:
            return "americas.api.riotgames.com"
        case .eun1, .euw1, .tr1:
            return "europe.api.riotgames.com"
        case .jp1, .kr1, .ru, .th2, .tw2, .vn2:
            return "asia.api.riotgames.com"
        case .oc1, .ph2, .sg2:
            return "sea.api.riotgames.com"
        }
    }

    var platformRouting: String {
        switch self {
        case .br1:
            return "br1.api.riotgames.com"
        case .eun1:
            return "eun1.api.riotgames.com"
        case .euw1:
            return "euw1.api.riotgames.com"
        case .jp1:
            return "jp1.api.riotgames.com"
        case .kr1:
            return "kr.api.riotgames.com"
        case .la1:
            return "la1.api.riotgames.com"
        case .la2:
            return "la2.api.riotgames.com"
        case .na1:
            return "na1.api.riotgames.com"
        case .oc1:
            return "oc1.api.riotgames.com"
        case .tr1:
            return "tr1.api.riotgames.com"
        case .ru:
            return "ru.api.riotgames.com"
        case .ph2:
            return "ph2.api.riotgames.com"
        case .sg2:
            return "sg2.api.riotgames.com"
        case .th2:
            return "th2.api.riotgames.com"
        case .tw2:
            return "tw2.api.riotgames.com"
        case .vn2:
            return "vn2.api.riotgames.com"
        }
    }

    static func getRegion(for regionName: String) -> RiotRegion? {
        return Self.allCases.first(where: {$0.rawValue == regionName})
    }
}
