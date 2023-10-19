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
    var name: String
    var latitude: String
    var longitude: String
    
    public init(name: String, latitude: String, longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(name: String, latitude: Double, longitude: Double) {
        self.init(name: name, latitude: "\(latitude)", longitude: "\(longitude)")
    }
    
    init() {
        self.init(name: "", latitude: "", longitude: "")
    }
}
