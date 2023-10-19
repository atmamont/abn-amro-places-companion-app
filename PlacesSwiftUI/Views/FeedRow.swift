//
//  FeedRow.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import SwiftUI

struct FeedRow: View {
    let location: LocationViewModel
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "location.circle")
            VStack(alignment: .listRowSeparatorLeading) {
                if !location.name.isEmpty {
                    Text(location.name)
                        .font(.title)
                }
                VStack(alignment: .listRowSeparatorLeading)
                {
                    Text("Latitude: \(location.latitude)")
                        .font(.subheadline)
                    Text("Longitude: \(location.longitude)")
                        .font(.subheadline)
                }
            }
        }

    }
}

#Preview {
    VStack {
        FeedRow(
            location: LocationViewModel(
                name: "",
                latitude: "1.2323",
                longitude: "1.324343"
            )
        )
        FeedRow(
            location: LocationViewModel(
                name: "Amsterdam",
                latitude: "1.2323",
                longitude: "1.324343"
            )
        )
    }
}
