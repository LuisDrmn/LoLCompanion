//
//  LoLManager+Local.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 23/01/2023.
//

import Foundation

extension LoLManager {
    // MARK: - LOCAL SUMMONER
    func updateLocalSummoner() {
        print("Update Local")
        self.localSummoner = findLocalSummoner()
    }

    private func findLocalSummoner() -> Summoner? {
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
            print("MostRecentDate is \(mostRecentFileUrl?.absoluteString ?? "Not Found")")
            print("CreationDate: \(mostRecentFileUrl?.creationDateValue?.description ?? "Not Found")")
            print("ModifiedDate: \(mostRecentFileUrl?.modifiedDateValue?.description ?? "Not Found")")

            if let fileUrl = mostRecentFileUrl {
                var content = try String(contentsOf: fileUrl, encoding: .utf8)
                content = content.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)

                let regex = try NSRegularExpression(pattern: "\"id\":(\\d+),\"puuid\":\"([\\w-]+)\",\"accountId\":(\\d+),\"name\":\"([\\w]+)\"")
                if let match = regex.firstMatch(in: content, options: [], range: NSRange(location: 0, length: content.utf16.count)) {
                    let idRange = match.range(at: 1)
                    let idValue = String(content[Range(idRange, in: content)!])
                    let puuidRange = match.range(at: 2)
                    let puuidValue = String(content[Range(puuidRange, in: content)!])
                    let accountIdRange = match.range(at: 3)
                    let accountIdValue = String(content[Range(accountIdRange, in: content)!])
                    let nameRange = match.range(at: 4)
                    let nameValue = String(content[Range(nameRange, in: content)!])
                    localSummoner = Summoner(id: idValue, accountID: accountIdValue, puuid: puuidValue, name: nameValue, profileIconID: nil, revisionDate: nil, summonerLevel: nil)
                }
            }
        } catch {
            print("Couldn't read")

        }
        return localSummoner
    }
}
