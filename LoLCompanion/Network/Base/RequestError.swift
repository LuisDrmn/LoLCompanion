//
//  RequestError.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 22/01/2023.
//

import Foundation

enum RequestError: LocalizedError {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode(statusCode: String)
    case unknown
    case emptyRequest

    var errorDescription: String {
        switch self {
        case .decode:
            return "Unable to decode data"
        case .unauthorized:
            return "Session expired"
        case .unexpectedStatusCode(let statusCode):
            return "Unexpected Status Code: \(statusCode)"
        default:
            return "Unknown Error"
        }
    }

    var recoverySuggestion: String {
        switch self {
        case .decode:
            return "Try again later"
        default:
            return "Unknown Error"
        }
    }
}
