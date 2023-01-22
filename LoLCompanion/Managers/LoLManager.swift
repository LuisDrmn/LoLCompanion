//
//  LoLManger.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 21/01/2023.
//

import Foundation

struct Summoner {
    var id: String
    var puuid: String
    var accountId: String
    var name: String
}

class LoLManager: ObservableObject {

    init() {

    }

    func findUsername() -> Summoner? {
        var summoner: Summoner?
        let path = "/Applications/League of Legends.app/Contents/LoL/Logs/LeagueClient Logs"
        var mostRecentFileUrl: URL?

        do {
            let files = try FileManager().contentsOfDirectory(atPath: path)
            for file in files {
                if file.contains("LeagueClientUx.log") {
                    continue
                }
                let fileUrl = URL(filePath: path + "/" + file)

                if mostRecentFileUrl == nil {
                    mostRecentFileUrl = fileUrl
                }

                if let mostRecentFileDate = mostRecentFileUrl?.creationDateValue, let fileCreationDate = fileUrl.creationDateValue, mostRecentFileDate < fileCreationDate {
                    mostRecentFileUrl = fileUrl
                }

            }
            print("MostRecentDate is \(mostRecentFileUrl) \(mostRecentFileUrl?.creationDateValue) \(mostRecentFileUrl?.modifiedDateValue) \n")

            if let fileUrl = mostRecentFileUrl {
                var content = try String(contentsOf: fileUrl, encoding: .utf8)
                content = content.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)

                let regex = try NSRegularExpression(pattern: "\"id\":(\\d+),\"puuid\":\"([\\w-]+)\",\"accountId\":(\\d+),\"name\":\"([\\w]+)\"")
                if let match = regex.firstMatch(in: content, options: [], range: NSRange(location: 0, length: content.utf16.count)) {
                    let idRange = match.range(at: 1)
                    let idValue = String(content[Range(idRange, in: content)!])
                    print("USER ID:")
                    print("id: \(idValue)") // id: 20366200
                    let puuidRange = match.range(at: 2)
                    let puuidValue = String(content[Range(puuidRange, in: content)!])
                    print("puuid: \(puuidValue)") // puuid: f2e88d10-ba0a-5098-adc6-c1502e15386a
                    let accountIdRange = match.range(at: 3)
                    let accountIdValue = String(content[Range(accountIdRange, in: content)!])
                    print("accountId: \(accountIdValue)") // accountId: 23357841
                    let nameRange = match.range(at: 4)
                    let nameValue = String(content[Range(nameRange, in: content)!])
                    print("name: \(nameValue)") // name: McBallz
                    summoner = Summoner(id: idValue, puuid: puuidValue, accountId: accountIdValue, name: nameValue)
                }
            }
        } catch {
            print("Couldn't read")

        }
        return summoner
    }
}

extension URL {
    var metadataItemAttributes: [String]? {
        return  NSMetadataItem(url: self)?.attributes
    }
    var creationDateValue: Date? {
        return  NSMetadataItem(url: self)?.value(forAttribute: NSMetadataItemFSCreationDateKey) as? Date
    }
    var modifiedDateValue: Date? {
        return  NSMetadataItem(url: self)?.value(forAttribute: NSMetadataItemFSContentChangeDateKey) as? Date
    }
    var nameValue: String? {
        return  NSMetadataItem(url: self)?.value(forAttribute: NSMetadataItemFSNameKey) as? String
    }
    var displayNameValue: String? {
        return  NSMetadataItem(url: self)?.value(forAttribute: NSMetadataItemDisplayNameKey) as? String
    }
    var fileSizeValue: Int? {
        return  (NSMetadataItem(url: self)?.value(forAttribute: NSMetadataItemFSSizeKey) as? NSNumber)?.intValue
    }
}

extension [Date] {
    func mostRecentDate() -> Date {
        var mostRecentDate: Date? = nil

        for date in self {
            if mostRecentDate == nil {
                mostRecentDate = date
            }

            if let recentDate = mostRecentDate, recentDate < date {
                mostRecentDate = date
            }
        }

        return mostRecentDate ?? Date.now
    }
}

