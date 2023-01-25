//
//  GameRsume.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 25/01/2023.
//

import Foundation

struct GameResume: Identifiable {
    var id: Int
    var championName: String
    var win: Bool
    var kills, deaths, assits: Int
    var queueID: Int
}
