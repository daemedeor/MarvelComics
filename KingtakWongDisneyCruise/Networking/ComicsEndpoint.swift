//
//  ComicsEndpoint.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

class ComicEndpoint: BaseNetworkClass, NetworkEndpointProtocol {
    typealias dataType = ComicResponse
    
    //Endpoints are statically defined here to help define getting to the end
    var endPoint = "comics"

    /**
     This is built locally to help facilitate differences in how building the URL can happen depending on the endpoint information. This could make this extremely complex but since its really just buliding it on a few properties, this can be set for now.... can potentionally be optimized later depending on use case
     */
    var baseURL: URLComponents? {
        var url = URLComponents(string: "\(self.credential.urlBase)\(self.endPoint)")

        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(self.credential.privateAPIKey)\(self.credential.apitoken)".md5()

        let authItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: self.credential.apitoken),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        url?.queryItems = authItems

        return url
    }
    
    func updatedUrl(offset: Int, limit: Int? = nil) -> URL? {
        guard var newURL = self.baseURL else { return nil }
        
        newURL.queryItems?.append(URLQueryItem(name: "offset", value: "\(offset)"))
        
        if let newLimit = limit {
            newURL.queryItems?.append(URLQueryItem(name: "limit", value: "\(newLimit)"))
        }
        
        return newURL.url
    }

    override init(credential: Credential) {
        super.init(credential: credential)
    }
}


