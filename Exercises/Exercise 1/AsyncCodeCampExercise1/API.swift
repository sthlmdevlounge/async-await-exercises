import Foundation
import UIKit

enum APIError: Error {
    case badStatusCode
    case badData
}

public enum API {

    public static func fetchImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(APIError.badStatusCode))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(APIError.badData))
                return
            }

            completion(.success(image))

        }

        task.resume()

    }

    // Implement 1.4 here!

    // Implement 1.7 here!    

}
