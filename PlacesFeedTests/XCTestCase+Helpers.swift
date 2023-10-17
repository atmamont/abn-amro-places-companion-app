//
//  XCTestCase+Helpers.swift
//  PlacesFeedTests
//
//  Created by Andrei on 17/10/2023.
//

import XCTest

extension XCTestCase {
    func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
    
    func anyNSError() -> NSError {
        NSError(domain: "any domain", code: 0)
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
