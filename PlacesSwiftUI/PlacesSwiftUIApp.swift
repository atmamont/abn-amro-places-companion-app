//
//  PlacesSwiftUIApp.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 18/10/2023.
//

import SwiftUI

@main
struct PlacesSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            FeedUIComposer.composeFeed()
        }
    }
}
