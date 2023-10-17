//
//  PlacesLoader.swift
//  PlacesFeed
//
//  Created by Andrei on 17/10/2023.
//

import Foundation

public struct Location: Equatable {
    public let latitude: Double
    public let longitude: Double
    public let name: String
}

public protocol FeedLoader {
    typealias LoadResult = Result<[Location], Error>

    func load(completion: @escaping (LoadResult) -> Void)
}
