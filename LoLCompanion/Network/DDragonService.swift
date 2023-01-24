//
//  DDragonService.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 24/01/2023.
//

import Foundation
import SwiftUI

typealias PatchVersions = [String]

protocol DDragonServiceable {
    func getLastVersion() async -> Result<PatchVersions, RequestError>
    func getChampionImgUrl(for championName: String, with patchVersion: String) -> URL?
    func getProfileIconImgUrl(for profileIcon: Int, with patchVersion: String) -> URL?

}

struct DDragonService: HTTPClient, DDragonServiceable {
    func getChampionImgUrl(for championName: String, with patchVersion: String) -> URL? {
        let endpoint = DDragonEndpoint.getChampionImg(championName: championName, patchVersion: patchVersion)

        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        return urlComponents.url
    }

    func getProfileIconImgUrl(for profileIcon: Int, with patchVersion: String) -> URL? {
        let endpoint = DDragonEndpoint.getProfileIconImg(profileIcon: String(profileIcon), patchVersion: patchVersion)

        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        return urlComponents.url
    }

    func getLastVersion() async -> Result<PatchVersions, RequestError> {
        await sendRequest(endpoint: DDragonEndpoint.getVersions, responseModel: PatchVersions.self)
    }
}
