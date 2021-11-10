
import Foundation
import UIKit

extension API {

    public static func deprecatedButAsyncFetchImage(url: URL) async throws -> UIImage {
        return try await withCheckedThrowingContinuation { continuation in
            deprecatedFetchImage(url: url) { result in
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
