//
//  SearchResults.swift
//  Photo Gallery
//
//  Created by Deniro21 on 1/15/20.
//  Copyright © 2020 Denys Hryshyn. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue: String]
    
    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
