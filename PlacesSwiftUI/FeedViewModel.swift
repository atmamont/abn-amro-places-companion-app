//
//  Feed.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI
import PlacesFeed

struct LocationViewModel {
    let name: String?
    let latitude: String
    let longitude: String
}

@Observable 
final class FeedViewModel {
    private let loader: FeedLoader

    var items: [LocationViewModel] = []
    private(set) var isLoading: Bool = false
    
    init(loader: FeedLoader) {
        self.loader = loader
    }

    func loadFeed() {
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
                name: $0.name,
                latitude: "\($0.latitude)",
                longitude: "\($0.longitude)"
            )
        }
    }
}

extension FeedViewModel {
    func openExternalURL(for location: LocationViewModel) {
        if let externalURL = makeURL(from: location), UIApplication.shared.canOpenURL(externalURL) {
            UIApplication.shared.open(externalURL)
        }
    }
    
    private func makeURL(from location: LocationViewModel) -> URL? {
        var components = URLComponents()
        components.scheme = "wikpedia"
        components.host = "places"
        components.queryItems = makeQueryItems(from: location)
        return components.url
    }

    private func makeQueryItems(from location: LocationViewModel) -> [URLQueryItem] {
        var items = [URLQueryItem(name: "latitude", value: location.latitude),
                     URLQueryItem(name: "longitude", value: location.latitude)]
        if let name = location.name {
            items.append(URLQueryItem(name: "name", value: name))
        }
        return items
    }
}

extension LocationViewModel: Identifiable {
    public var id: String {
        "\(latitude),\(longitude)"
    }
}

extension FeedViewModel {
    static var prototype: FeedViewModel {
        FeedViewModel(loader: MockLoader())
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
