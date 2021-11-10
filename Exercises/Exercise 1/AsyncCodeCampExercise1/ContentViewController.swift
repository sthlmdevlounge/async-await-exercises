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

        // 1.6: Replace this function call.

         API.fetchImage(url: imageURL) { [weak self] result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let image):
                     self?.imageView.image = image
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
        }
    
    }

}
