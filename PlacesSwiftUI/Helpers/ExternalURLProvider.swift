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

final class ExternalURLProvider: URLProvider {
    func makeURL(from location: LocationViewModel) -> URL {
        var components = URLComponents()
        components.scheme = "wikpedia"
        components.host = "places"
        components.queryItems = makeQueryItems(from: location)
        return components.url!
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
