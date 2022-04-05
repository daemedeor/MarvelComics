//
//  ComicsViewModel.swift
//  KingtakWongDisneyCruise
//
//  Created by Kingtak Justin Wong on 4/4/22.
//

import Foundation

class ComicsViewModel {
    private var response: IteratorData?
    let endpoint: ComicEndpoint
    var comics = [Comic]()
    private(set) var isFetching = false

    init(endpoint: ComicEndpoint) {
        self.endpoint = endpoint
    }
    
    func initalizeData() async throws {
        NotificationCenter.default.post(name: .loadingComics, object: nil)

        let newRetrivedData = try await retrieveData(with: 0)
        comics = newRetrivedData.comics
        response = newRetrivedData.iterator
        
        NotificationCenter.default.post(name: .finishedLoadingComics, object: nil)
    }
    
    private func retrieveData(with offset: Int = 0) async throws -> (comics: [Comic], iterator: IteratorData) {
        let newDataResponse = try await endpoint.downloadData(from: endpoint.updatedUrl(offset: offset, limit: 100))
        
        guard newDataResponse.code == 200 else { throw NetworkError.failedResponse }
        
        return (newDataResponse.data.results, newDataResponse.data)
    }
    
    func getMoreComics() throws {
        isFetching = true

        guard let previousOffset = response?.offset, let totalCount = response?.count, !endpoint.isExecuting else { return }
        
        Task {
            defer {
                self.isFetching = false
            }
    
            let nextDataPage = try await retrieveData(with: previousOffset + totalCount)
            var newComicsSet = Set(self.comics)
            
            for comic in nextDataPage.comics {
                newComicsSet.insert(comic)
            }
            self.comics = Array(newComicsSet)
            response?.offset = previousOffset + totalCount
            NotificationCenter.default.post(name: .finishedLoadingComics, object: nil)
        }
    }
}

extension Notification.Name {
    static let loadingComics = Notification.Name("LoadingComicsNotification")
    static let finishedLoadingComics = Notification.Name("FinishedLoadingComicsNotification")
}
