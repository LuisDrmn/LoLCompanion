//
//  SummonerName.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

struct Summoner: Codable {
    let id, accountID, puuid, name: String
    let profileIconID, revisionDate, summonerLevel: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "accountId"
        case puuid, name
        case profileIconID = "profileIconId"
        case revisionDate, summonerLevel
    }
}
