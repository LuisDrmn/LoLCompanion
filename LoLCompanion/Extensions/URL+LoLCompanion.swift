//
//  URL+LoLCompanion.swift
//  LoLCompanion
//
//  Created by Jean-Louis Darmon on 23/01/2023.
//

import Foundation

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
