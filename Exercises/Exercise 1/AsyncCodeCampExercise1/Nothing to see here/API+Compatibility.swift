import Foundation
import UIKit

extension API {

    static func fetchImage_1_1(url: URL) async throws -> UIImage {
        return try await withCheckedThrowingContinuation { continuation in
            fetchImage(url: url) { result in
                switch result {
                case .success(let image):
                    continuation.resume(returning: image)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}
