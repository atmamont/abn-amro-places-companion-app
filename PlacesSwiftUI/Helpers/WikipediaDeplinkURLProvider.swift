//
//  ExternalURLProvider.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import Foundation

protocol URLProvider {
    func makeURL(from location: LocationViewModel) -> URL
}

public final class WikipediaDeplinkURLProvider: URLProvider {
    public init() {}
    
    public func makeURL(from location: LocationViewModel) -> URL {
        var components = URLComponents()
        components.scheme = "wikipedia"
        components.host = "places"
        components.queryItems = makeQueryItems(from: location)
        return components.url!
    }

    private func makeQueryItems(from location: LocationViewModel) -> [URLQueryItem] {
        var items = [URLQueryItem(name: "latitude", value: location.latitude),
                     URLQueryItem(name: "longitude", value: location.longitude)]
        if !location.name.isEmpty {
            items.append(URLQueryItem(name: "name", value: location.name))
        }
        return items
    }
}
