import Foundation
import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {

    @Published private(set) var image: UIImage?

    private let imageURL: URL = URL(string: "https://developer.apple.com/news/images/og/swiftui-og.png")!

    func deprecatedFetchImage() {
        API.fetchImage(url: imageURL) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let image):
                    self?.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // 1.1: Implement here.

}
