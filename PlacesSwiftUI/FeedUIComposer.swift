//
//  FeedUIComposer.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import Foundation
import PlacesFeed

final class FeedUIComposer {
    private init() {}
    
    static func composeFeed() -> FeedView {
        let httpClient = URLSessionHTTPClient()
        let loader = RemoteFeedLoader(client: httpClient)
        let feed = FeedViewModel(loader: loader)
        return FeedView(feed: feed)
    }
}
