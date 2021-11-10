
import Foundation
import UIKit

final class ContentViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var fetchButton: UIButton!

    private let imageURL: URL = URL(string: "https://developer.apple.com/news/images/og/swiftui-og.png")!

    init() {
        super.init(nibName: "ContentViewController", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchButton.setTitle("Tap me to fetch image", for: .normal)
    }

    @IBAction private func fetchButtonTapped(_ sender: Any) {

        // 1.6: Implement here.

        Task { @MainActor in
            do {
                self.imageView.image = try await API.deprecatedButAsyncFetchImage(url: imageURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    
    }

}
