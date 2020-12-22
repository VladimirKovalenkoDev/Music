//
//  SearchItems.swift
//  Music
//
//  Created by Владимир Коваленко on 20.12.2020.
//

import Foundation
struct Results: Codable {
    let results: [SearchItems]
}
struct SearchItems: Codable {
    let artistName: String?
    let copyright: String?
    let trackName: String?
    let collectionName: String?
    let artworkUrl100: String?
}
