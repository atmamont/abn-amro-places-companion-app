//
//  ExternalURLProviderTests.swift
//  PlacesSwiftUITests
//
//  Created by Andrei on 19/10/2023.
//

import XCTest
import PlacesFeed
import PlacesSwiftUI

final class WikipediaDeplinkURLProviderTests: XCTestCase {
    
    func test_makeURL_returnsCorrectURL() {
        let expectedUrl = URL(string: "wikipedia://places?latitude=1.0&longitude=1.2345678&name=Amsterdam")!
        let location = LocationViewModel(name: "Amsterdam", latitude: "1.0", longitude: "1.2345678")
        let sut = WikipediaDeplinkURLProvider()
        
        let url = sut.makeURL(from: location)
        
        XCTAssertEqual(url, expectedUrl)
    }
    
    func test_makeURL_returnsCorrectURLWhenNameIsEmpty() {
        let expectedUrl = URL(string: "wikipedia://places?latitude=1.0&longitude=1.2345678")!
        let location = LocationViewModel(name: "", latitude: "1.0", longitude: "1.2345678")
        let sut = WikipediaDeplinkURLProvider()
        
        let url = sut.makeURL(from: location)
        
        XCTAssertEqual(url, expectedUrl)
    }
}
