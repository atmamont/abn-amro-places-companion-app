//
//  FeedView.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI

struct FeedView: View {
    @State var feed: FeedViewModel
    let urlProvider: URLProvider
    
    var body: some View {
        NavigationView {
            if feed.isLoading {
                ProgressView()
            } else {
                List(feed.items) { location in
                    FeedRow(location: location)
                        .onTapGesture {
                            openExternalURL(for: location)
                    }
                }
                .navigationTitle("Locations")
            }
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: feed.loadFeed)
    }
    
    private func openExternalURL(for location: LocationViewModel) {
        let externalURL = urlProvider.makeURL(from: location)
        if UIApplication.shared.canOpenURL(externalURL) {
            UIApplication.shared.open(externalURL)
        }
    }

}

#Preview {
    FeedView(feed: LocationFeedViewModel.prototype, urlProvider: MockURLProvider())
}

private final class MockURLProvider: URLProvider {
    func makeURL(from location: LocationViewModel) -> URL {
        URL(string: "http://any-url.com")!
    }
}
