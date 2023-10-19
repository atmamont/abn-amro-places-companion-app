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
                .navigationTitle("Pick location")
                .toolbar(content: {
                    NavigationLink("Open custom location", destination: CustomLocationView(viewModel: LocationViewModel(), urlProvider: urlProvider))
                                  
                })
            }
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: feed.loadFeed)
    }
    
    private func openExternalURL(for location: LocationViewModel) {
        let externalURL = urlProvider.makeURL(from: location)
        UIApplication.shared.open(externalURL)
    }

}

#Preview {
    FeedView(feed: LocationFeedViewModel.prototype, urlProvider: MockURLProvider())
}

final class MockURLProvider: URLProvider {
    func makeURL(from location: LocationViewModel) -> URL {
        URL(string: "http://any-url.com")!
    }
}
