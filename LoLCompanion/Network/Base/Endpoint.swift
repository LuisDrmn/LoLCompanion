//
//  Endpoint.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var urlQueryItems: [URLQueryItem]? { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var description: String { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }

    var description: String {
        return "Scheme: \(scheme) Host: \(host) Path: \(path) Method: \(method.rawValue)"
    }
}
