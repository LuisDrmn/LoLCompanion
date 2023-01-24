//
//  DDragonManager.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 24/01/2023.
//

import Foundation

class DDragonManager: ObservableObject {
    static let shared = DDragonManager()

    var dragonService = DDragonService()
    var lastVersion: String?

    init() {
        fetchLastPatchVersion()
    }

    func fetchLastPatchVersion() {
        Task {
            let result = await dragonService.getLastVersion()
            switch result {
            case .success(let success):
                if let first = success.first {
                    self.lastVersion = first
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func getChampionURL(for championName: String, patchVersions: String) -> URL? {
        dragonService.getChampionImgUrl(for: championName, with: patchVersions)
    }

    func getProfileURL(for pofileIcon: Int, patchVersions: String) -> URL? {
        dragonService.getProfileIconImgUrl(for: pofileIcon, with: patchVersions)
    }
}
