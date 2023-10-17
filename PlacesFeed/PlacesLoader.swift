//
//  PlacesLoader.swift
//  PlacesFeed
//
//  Created by Andrei on 17/10/2023.
//

import Foundation

public struct PlaceItem: Equatable {
    public let latitude: Double
    public let longitude: Double
    public let name: String
}

public protocol PlacesLoader {
    typealias LoadResult = Result<[PlaceItem], Error>

    func load(completion: @escaping (LoadResult) -> Void)
}
