//
//  IteratorData.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

struct IteratorData: Codable {
    var offset: Int
    let limit: Int
    var total: Int
    var count: Int
    let results: [Comic]
}
