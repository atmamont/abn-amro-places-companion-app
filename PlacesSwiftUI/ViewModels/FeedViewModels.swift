//
//  FeedViewModels.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import Foundation

protocol FeedViewModel {
    var isLoading: Bool { get }
    var items: [LocationViewModel] { get }
    
    func loadFeed()
}

struct LocationViewModel {
    let name: String?
    let latitude: String
    let longitude: String
}
