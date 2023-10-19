//
//  Feed.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import Foundation
import PlacesFeed

public protocol FeedViewModel {
    var isLoading: Bool { get }
    var items: [LocationViewModel] { get }
    
    func loadFeed()
}

@Observable
public class LocationFeedViewModel: FeedViewModel {
    private let loader: FeedLoader

    public var items: [LocationViewModel] = []
    private(set) public var isLoading: Bool = false
    
    public init(loader: FeedLoader) {
        self.loader = loader
    }

    public func loadFeed() {
        isLoading = true
        loader.load { [weak self] result in
            self?.isLoading = false
            if let feed = try? result.get(), let mappedFeed = self?.map(feed) {
                self?.items = mappedFeed
            }
        }
    }
    
    private func map(_ feed: [Location]) -> [LocationViewModel] {
        feed.map {
            LocationViewModel(
                name: $0.name ?? "",
                latitude: "\($0.latitude)",
                longitude: "\($0.longitude)"
            )
        }
    }
}

extension LocationViewModel: Identifiable {
    public var id: String {
        "\(latitude),\(longitude)"
    }
}

extension LocationFeedViewModel {
    static var prototype: FeedViewModel {
        LocationFeedViewModel(loader: MockLoader())
    }
    
    private final class MockLoader: FeedLoader {
        func load(completion: @escaping (LoadResult) -> Void) {
            completion(.success(
                [Location(name: nil, latitude: 40.4380638, longitude: -3.7495758),
                 Location(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
            ]))
        }
    }
}
