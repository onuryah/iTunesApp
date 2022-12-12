//
//  MediaModel.swift
//  iTunesApp
//
//  Created by admin on 12.12.2022.
//

import Foundation

struct MediaResponse: Codable {
    let resultCount: Int
    let results: [Media]
}

struct Media: Codable {
    let screenshotUrls: [String]
}
