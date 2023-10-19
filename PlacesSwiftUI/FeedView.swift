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
                    FeedRow(location: location)
                        .onTapGesture {
                            feed.openExternalURL(for: location)
                    }
                }
                .navigationTitle("Locations")
            }
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: feed.loadFeed)
    }
}


#Preview {
    FeedView(feed: FeedViewModel.prototype)
}

