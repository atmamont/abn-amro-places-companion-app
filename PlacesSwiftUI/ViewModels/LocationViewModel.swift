//
//  LocationViewModel.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import Foundation

@Observable
public final class LocationViewModel {
    var name: String
    var latitude: String
    var longitude: String
    
    public init(name: String, latitude: String, longitude: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience public init(name: String, latitude: Double, longitude: Double) {
        self.init(name: name, latitude: "\(latitude)", longitude: "\(longitude)")
    }
    
    convenience init() {
        self.init(name: "", latitude: "", longitude: "")
    }
}

extension LocationViewModel: Equatable {
    public static func == (lhs: LocationViewModel, rhs: LocationViewModel) -> Bool {
        lhs.name == rhs.name &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}

extension LocationViewModel {
    var isValid: Bool {
        !latitude.isEmpty && !longitude.isEmpty
    }
}
