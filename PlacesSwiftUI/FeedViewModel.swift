//
//  Feed.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI
import PlacesFeed

protocol FeedViewModelProtocol {
    var items: [Location] { get }
    var isLoading: Bool { get }
    
    func loadFeed()
    func openExternalURL(for location: Location)
}

@Observable final class FeedViewModel: FeedViewModelProtocol {
    private let loader: FeedLoader

    var items: [Location] = []
    private(set) var isLoading: Bool = false
    
    init(loader: FeedLoader) {
        self.loader = loader
    }

    func loadFeed() {
        isLoading = true
        loader.load { [weak self] result in
            self?.isLoading = false
            if let feed = try? result.get() {
                self?.items = feed
            }
        }
    }
}

extension FeedViewModel {
    func openExternalURL(for location: Location) {
        if let externalURL = makeURL(from: location), UIApplication.shared.canOpenURL(externalURL) {
            UIApplication.shared.open(externalURL)
        }
    }
    
    private func makeURL(from location: Location) -> URL? {
        var components = URLComponents()
        components.scheme = "wikpedia"
        components.host = "places"
        components.queryItems = makeQueryItems(from: location)
        return components.url
    }

    private func makeQueryItems(from location: Location) -> [URLQueryItem] {
        [URLQueryItem(name: "latitude", value: "\(location.latitude)"),
         URLQueryItem(name: "longitude", value: "\(location.latitude)"),
         URLQueryItem(name: "name", value: "\(location.name)")]
    }
}

extension Location: Identifiable {
    public var id: String {
        "\(latitude),\(longitude),\(name)"
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
