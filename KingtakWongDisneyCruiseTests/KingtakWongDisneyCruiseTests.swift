//
//  KingtakWongDisneyCruiseTests.swift
//  KingtakWongDisneyCruiseTests
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import XCTest
@testable import KingtakWongDisneyCruise

class KingtakWongDisneyCruiseTests: XCTestCase {


    var credentials: ProdInformation!
    var endpoint: ComicEndpoint!

    let savedAPIKey = "3SDF8DF9SDF0"
    let newURL = "https://www.google.com"
    
    override func setUpWithError() throws {
        credentials = ProdInformation(type: .testing(savedAPIKey, newURL))
        endpoint = ComicEndpoint(credential: credentials)
    }

    func testSvaedAPIKey() throws {
        let fullModelURL = endpoint.updatedUrl(offset: 0)?.absoluteString
        
        assert(fullModelURL?.contains(savedAPIKey) ?? false)
        assert(fullModelURL?.contains(newURL) ?? false)
    }

    func testSvaedAPIKey() throws {
        assert(credentials.urlBase == newURL)
        assert(credentials.apitoken == savedAPIKey)
    }


}
