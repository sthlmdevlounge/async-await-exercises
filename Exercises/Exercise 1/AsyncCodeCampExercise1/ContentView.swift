import Foundation
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {

        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }

        Button {

            // 1.2: Replace this code below.

            viewModel.deprecatedFetchImage()
            
        } label: {
            Text("Tap me to fetch image")
        }

    }
}
