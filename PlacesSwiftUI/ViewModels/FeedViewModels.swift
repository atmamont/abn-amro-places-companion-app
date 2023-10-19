//
//  FeedViewModels.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import Foundation

public protocol FeedViewModel {
    var isLoading: Bool { get }
    var items: [LocationViewModel] { get }
    
    func loadFeed()
}

public struct LocationViewModel: Equatable {
    let name: String?
    let latitude: String
    let longitude: String
    
    public init(name: String? = nil, latitude: String, longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(name: String? = nil, latitude: Double, longitude: Double) {
        self.init(name: name, latitude: "\(latitude)", longitude: "\(longitude)")
    }
}
