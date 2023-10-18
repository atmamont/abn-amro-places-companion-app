//
//  Feed.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI
import PlacesFeed

@Observable final class FeedViewModel {
    var items: [Location] = [Location(name: "Amsterdam", latitude: 1, longitude: 1)]
}

extension FeedViewModel {
    static var prototype: FeedViewModel {
        FeedViewModel()
    }
    
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
