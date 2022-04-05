//
//  ComicCreators.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

struct ComicCreators: Codable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [CreatorItems]
}
