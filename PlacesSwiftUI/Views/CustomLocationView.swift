//
//  CustomLocationView.swift
//  PlacesSwiftUI
//
//  Created by Andrei on 19/10/2023.
//

import SwiftUI

struct CustomLocationView: View {
    @State var viewModel: LocationViewModel
    let urlProvider: URLProvider
    
    var body: some View {
        VStack {
            Form {
                LabeledContent {
                    TextField("Name", text: $viewModel.name)
                } label: {
                    Text("Name")
                }

                LabeledContent {
                    TextField("Latitude", text: $viewModel.latitude)
                        
                } label: {
                    Text("Latitude")
                }
                
                LabeledContent {
                    TextField("Longitude", text: $viewModel.longitude)
                } label: {
                    Text("Longitude")
                }
            }.multilineTextAlignment(.trailing)
            
            VStack(alignment: .center) {
                Button("Open") {
                    openExternalURL(for: viewModel)
                }.disabled(!viewModel.isValid)
            }
            Spacer()
        }
        .navigationTitle("Open custom location")
    }

    private func openExternalURL(for location: LocationViewModel) {
        let externalURL = urlProvider.makeURL(from: location)
        UIApplication.shared.open(externalURL)
    }
}

#Preview {
    CustomLocationView(viewModel: LocationViewModel(name: "", latitude: 0.0, longitude: 0.0), urlProvider: MockURLProvider())
}
