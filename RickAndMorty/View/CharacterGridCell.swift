import UIKit

class CharacterGridCell: UICollectionViewCell {
    
    private let containerView = CustomContainerView()
    private let imageView = CustomImageView()
    private let nameLabel = CustomLabel(fontSize: 16, weight: .semibold, lines: 2, alignment: .center)
    private let statusLabel = CustomLabel(fontSize: 14, color: .secondaryLabel, alignment: .center)
    private let speciesLabel = CustomLabel(fontSize: 14, color: .secondaryLabel, alignment: .center)
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel, statusLabel, speciesLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.pinToEdges(of: contentView)
        containerView.addSubview(stackView)
        stackView.pinToEdges(of: containerView)
        imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
        speciesLabel.text = nil
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = character.status?.rawValue
        speciesLabel.text = character.species?.rawValue
        imageView.loadImage(from: character.image ?? "")
    }
}
