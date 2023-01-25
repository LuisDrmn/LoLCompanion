//
//  LeagueEntry.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 25/01/2023.
//

import Foundation

struct RankedStatus: Codable {
    let leagueId: Int
    let rank: String
    let wins, losses, leaguePoints: Int
}
