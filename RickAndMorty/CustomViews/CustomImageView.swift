import UIKit

class CustomImageView: UIImageView {
    init(cornerRadius: CGFloat = 8) {
        super.init(frame: .zero)
        setupUI(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI(cornerRadius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
    }
} 
