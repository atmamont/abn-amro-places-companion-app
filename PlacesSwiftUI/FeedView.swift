//
//  FeedView.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI


struct FeedView: View {
    @State var feed: FeedViewModelProtocol
    
    var body: some View {
        NavigationView {
            if feed.isLoading {
                ProgressView()
            } else {
                List(feed.items) { location in
                    VStack {
                        if let name = location.name {
                            Text(name)
                        }
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
        }
        .padding()
        .navigationViewStyle(.stack)
        .onAppear(perform: feed.loadFeed)
    }
}


#Preview {
    FeedView(feed: FeedViewModel.prototype)
}

