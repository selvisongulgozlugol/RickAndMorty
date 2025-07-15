import UIKit

class CustomLabel: UILabel {
    init(
        fontSize: CGFloat,
        weight: UIFont.Weight = .regular,
        color: UIColor = .label,
        lines: Int = 1,
        alignment: NSTextAlignment = .natural
    ) {
        super.init(frame: .zero)
        setupUI(fontSize: fontSize, weight: weight, color: color, lines: lines, alignment: alignment)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI(
        fontSize: CGFloat,
        weight: UIFont.Weight,
        color: UIColor,
        lines: Int,
        alignment: NSTextAlignment
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        font = .systemFont(ofSize: fontSize, weight: weight)
        textColor = color
        numberOfLines = lines
        textAlignment = alignment
    }
} 
