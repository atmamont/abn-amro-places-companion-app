//
//  FeedView.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI


struct FeedView: View {
    @State var feed: FeedViewModel
    
    var body: some View {
        NavigationView {
            List(feed.items) { location in
                VStack {
                    Text(location.name)
                    HStack {
                        Text("\(location.latitude)")
                        Text("\(location.longitude)")
                    }
                }
                .onTapGesture {
                    feed.openExternalURL(for: location)
                }
            }
            .navigationTitle("Locations")
        }
        .padding()
        .navigationViewStyle(.stack)
    }
}


#Preview {
    FeedView(feed: FeedViewModel.prototype)
}

