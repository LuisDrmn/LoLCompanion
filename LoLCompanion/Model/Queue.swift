//
//  Queue.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 25/01/2023.
//

import Foundation

struct Queue: Codable {
    let queueID: Int
    let map: String
    let description, notes: String?

    enum CodingKeys: String, CodingKey {
        case queueID = "queueId"
        case map, description, notes
    }
}
