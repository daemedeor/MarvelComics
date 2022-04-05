//
//  ProdInformation.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

struct ProdInformation: Credential {
    let apitoken: String
    let urlBase: String
    let privateAPIKey = "d6c2bad8d4d91c300648178f8702b85b2b4142df"

    // Modeled to have a singleton ... just to encourage ease of use in the main app... :shrug:
    static let shared: ProdInformation = ProdInformation(type: .production)

    /**
     Could even save the type to the object to define other more complex properties.
     However, since this really involves the api tokens and url base, just to show its "technically doable' even though they are the same values for now
     */
    init(type: Endpoint = .production) {
        // Ideally this is unique to separate the different environments QA/Prod/etc. includes a tseting one to test this struct further if there are more unqiue properties but since there's no concept of separation, just showing how this can further future testing of this struct for different ways this information can impact how stable this is
        switch type {
        case .production:
            self.apitoken = "8ea3f4f424e577ac998ec6cd0d47fa45"
            self.urlBase = "https://gateway.marvel.com:443/v1/public/"

        // Making a testing case like this to appropriately test this struct in unit tests
        case let .testing(apitoken, urlBase):
            self.apitoken = apitoken
            self.urlBase = urlBase
        }
    }
}
