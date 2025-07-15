import UIKit

extension UIView {
    func pinToEdges(of view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }
}

class CustomContainerView: UIView {
    init(
        backgroundColor: UIColor = .secondarySystemBackground,
        cornerRadius: CGFloat = 10,
        clipsToBounds: Bool = true
    ) {
        super.init(frame: .zero)
        setupUI(backgroundColor: backgroundColor, cornerRadius: cornerRadius, clipsToBounds: clipsToBounds)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI(
        backgroundColor: UIColor,
        cornerRadius: CGFloat,
        clipsToBounds: Bool
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
    }
} 