//
//  NetworkError.swift
//  20220321-KingtakWong-NYCSchools
//
//  Created by Kingtak Justin Wong on 3/19/22.
//

import Foundation

enum NetworkError: Error {
    case noData
    case noCredentials
    case failedToDecode
    case failedResponse
    case noValidURL
    case networkError
    case alreadyFetching
}
