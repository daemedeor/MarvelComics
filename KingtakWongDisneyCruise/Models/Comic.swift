//
//  Comic.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let digitalId: Int
    let title: String
    let issueNumber: Int
    let variantDescription: String
    let description: String?
    let modified: String
    let isbn: String
    let upc: String
    let diamondCode: String
    let ean: String
    let issn: String
    let format: String
    let pageCount: Int
    let resourceURI: String
    let urls: [ComicUrl]
    let series: ComicSeries
    let variants: [ComicVariants]
    let collections: [ComicCollections]
    let collectedIssues: [ComicIssues]
    let thumbnail: ComicThumbnail
    let images: [ComicImages]
    let creators: ComicCreators
}

extension Comic: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(id)
    }

       static func == (lhs: Comic,
                       rhs: Comic) -> Bool {
           return lhs.issueNumber == rhs.issueNumber &&
                  lhs.id == rhs.id &&
                  lhs.isbn == rhs.isbn
       }
}
