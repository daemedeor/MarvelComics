//
//  NetworkEndpointProtocol.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

protocol NetworkEndpointProtocol: AnyObject {
    /**
    This allows to easily know what types should be coming from the server and allows for data to be stored later but less than ideal since some endpoints may not have any data that need to be associated with them
     */
    associatedtype dataType: Codable

    // To help composibility, see notes on NYCEndpoint to get a better reasoning
    
    var baseURL: URLComponents? { get }
    var endPoint: String { get }
    
    var currentTask: URLSessionTask? { get set }

    func downloadData(from url: URL?) async throws -> dataType

    /**
     This is mostly to here to show I can make sure that the proper credentials depending on the end point can be tested and use DI to test the Networks but there may be better and simplier ways to (like a singleton struct set up that will be setup initially with a specific type e.g. production/qa). That would allow for more standard practice of reducing issues in the code base, could even reference a file that contains the credentials based on the environment that is swapped at run-time on the CI! However, keeping it as a property here to make sure that I'm not overengineering for a semi-small project that does not have CI attached
     */
    var credential: Credential { get }
}

extension NetworkEndpointProtocol {
    /**
     A standard download method to allow for quick and convinent use of having to rewrite download methods for each interface connects to this. This takes a lot of assumptions like that we want copies to litter every endpoind and not have a network engine that is totally decoupled from each of the end points, so its quicker to write gathering data on the main "app". However, a network engine that gathers data separately might also be an idea to explore.  Could also not use async / await to encourage even more backporting.... but using it to make it simplier to use Dispatch on main. Falling back on URL Task so that if the call needs to  be cancelled it can.. but none of these should take too long. Lots of discussion to be had around the different areas
    
     completion: function This allows the result after data is downloaded
    */
    func downloadData(from url: URL?) async throws -> dataType {
        guard let newURL = url else {
            print("?")
            throw NetworkError.noValidURL }

        let (data, response) = try await URLSession.shared.data(for:  URLRequest(url: newURL))
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.networkError
        }
        
        do {
            // There can be a lot more complex data modeling here and logic here to save to disk? Depends on what is asked for... here
            let decoder = JSONDecoder()
            let encodedData = try decoder.decode(dataType.self, from: data)
            return encodedData
        } catch {
            assert(true, "Issue with downloading data")
            throw NetworkError.failedToDecode
        }
    }

}
