import Foundation
import SwiftUI
import UIKit

class ColorAPI {
    static func fetchColor(forIndex index: Int, completion: @escaping (Color) -> Void) {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .random(in: 0.05...0.1)) {
            let x = index % 8
            let y = index / 8
            let image = UIImage.image(fromLayer: gradient)
            let color = image[x, y]!
            completion(.init(color))
        }
    }
}

let gradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
    gradient.startPoint = .init(x: 0, y: 0)
    gradient.endPoint = .init(x: 1, y: 1)

    let colors2: [UIColor] = [
        .init(red: 1, green: 0, blue: 0, alpha: 1),
        .init(red: 1, green: 0.5, blue: 0, alpha: 1),
        .init(red: 1, green: 1, blue: 0, alpha: 1),
        .init(red: 0, green: 1, blue: 0, alpha: 1),
        .init(red: 0, green: 0, blue: 1, alpha: 1),
        .init(red: 75/130, green: 0, blue: 130/255, alpha: 1),
        .init(red: 148/255, green: 0, blue: 211/255, alpha: 1)
    ]
    let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    gradient.colors = colors2.map { $0.cgColor }
    return gradient
}()

extension UIImage {
    static func image(fromLayer layer: CALayer) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: layer.bounds.size, format: format).image { context in
            layer.render(in: context.cgContext)
        }
    }

    subscript (x: Int, y: Int) -> UIColor? {
        guard
            let cfData = cgImage?.dataProvider?.data,
            let data = CFDataGetBytePtr(cfData)
        else {
            return nil
        }

        let offset = ((Int(size.width) * y) + x) * 4

        return .init(red: CGFloat(data[offset]) / 255,
                     green: CGFloat(data[offset + 1]) / 255,
                     blue: CGFloat(data[offset + 2]) / 255,
                     alpha: CGFloat(data[offset + 3]) / 255)
    }
}
