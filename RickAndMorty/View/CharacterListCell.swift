import UIKit

class CharacterListCell: UITableViewCell {
    private let containerView = CustomContainerView()
    private let characterImage = CustomImageView()
    private let nameLabel = CustomLabel(fontSize: 18, weight: .semibold, lines: 2)
    private let statusLabel = CustomLabel(fontSize: 16, color: .secondaryLabel)
    private let speciesLabel = CustomLabel(fontSize: 16, color: .secondaryLabel)
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, statusLabel, speciesLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [characterImage, labelsStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.pinToEdges(of: contentView, insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        containerView.addSubview(mainStackView)
        mainStackView.pinToEdges(of: containerView, insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        
        NSLayoutConstraint.activate([
            characterImage.widthAnchor.constraint(equalToConstant: 70),
            characterImage.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
        speciesLabel.text = nil
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = character.status.rawValue
        speciesLabel.text = character.species.rawValue
        characterImage.loadImage(from: character.image)
    }
}



