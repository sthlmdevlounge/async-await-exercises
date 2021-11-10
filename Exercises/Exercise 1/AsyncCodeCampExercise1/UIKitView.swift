import SwiftUI

struct UIKitView: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<UIKitView>) -> ContentViewController {
        ContentViewController()
    }

    func updateUIViewController(_ uiViewController: ContentViewController, context: UIViewControllerRepresentableContext<UIKitView>) {

    }

}
