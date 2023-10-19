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
            if feed.isLoading {
                ProgressView()
            } else {
                List(feed.items) { location in
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "location.circle")
                        VStack(alignment: .listRowSeparatorLeading) {
                            if let name = location.name {
                                Text(name)
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
                        .onTapGesture {
                            feed.openExternalURL(for: location)
                        }
                    }
                }
                .navigationTitle("Locations")
            }
        }
        .padding()
        .navigationViewStyle(.stack)
        .onAppear(perform: feed.loadFeed)
    }
}


#Preview {
    FeedView(feed: FeedViewModel.prototype)
}

