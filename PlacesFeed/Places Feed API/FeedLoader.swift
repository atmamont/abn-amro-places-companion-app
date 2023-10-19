//
//  PlacesLoader.swift
//  PlacesFeed
//
//  Created by Andrei on 17/10/2023.
//

import Foundation

public struct Location: Equatable {
    public let name: String?
    public let latitude: Double
    public let longitude: Double
    
    public init(name: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

public protocol FeedLoader {
    typealias LoadResult = Result<[Location], Error>

    func load(completion: @escaping (LoadResult) -> Void)
}
