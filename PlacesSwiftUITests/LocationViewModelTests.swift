//
//  LocationViewModelTests.swift
//  PlacesSwiftUITests
//
//  Created by Andrei on 19/10/2023.
//

import XCTest
import PlacesFeed
import PlacesSwiftUI

final class LocationViewModelTests: XCTestCase {
    func test_init_doesNotTriggerLoad() {
        let loader = FeedLoaderSpy()
        let _ = LocationFeedViewModel(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }

    func test_load_deliversItems() {
        let (loader, sut) = makeSUT()
        
        let items = [Location]()
        let expectedViewModels = items.map {
            LocationViewModel(name: $0.name ?? "", latitude: $0.latitude,longitude: $0.longitude)
        }

        withObservationTracking {
            let _ = sut.items
        } onChange: {
            XCTAssertEqual(sut.items, expectedViewModels)
        }

        sut.loadFeed()
        loader.completeWith(items)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (FeedLoaderSpy, LocationFeedViewModel) {
        let loader = FeedLoaderSpy()
        let sut = LocationFeedViewModel(loader: loader)

        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (loader, sut)
    }
    
    private class FeedLoaderSpy: FeedLoader {
        var loadCallCount: Int {
            requests.count
        }
        var requests: [(LoadResult) -> Void] = []
        
        func load(completion: @escaping (LoadResult) -> Void) {
            requests.append(completion)
        }
        
        func completeWith(_ items: [Location]) {
            requests[0](.success(items))
        }
    }
}
