import Foundation
import UIKit


class CharacterDetailsVC: UIViewController {
    private let character: Character
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let containerView = CustomContainerView(backgroundColor: .systemBackground)
    
    private let characterImage = CustomImageView(cornerRadius: 16)
    
    private let nameLabel = CustomLabel(fontSize: 28, weight: .bold, lines: 0, alignment: .center)
    private let statusLabel = CustomLabel(fontSize: 20, color: .secondaryLabel, alignment: .center)
    private let speciesLabel = CustomLabel(fontSize: 20, color: .secondaryLabel, alignment: .center)
    private let locationTitleLabel = CustomLabel(fontSize: 18, weight: .semibold, color: .label)
    private let locationLabel = CustomLabel(fontSize: 18, color: .secondaryLabel, lines: 0)
    private let originTitleLabel = CustomLabel(fontSize: 18, weight: .semibold, color: .label)
    private let originLabel = CustomLabel(fontSize: 18, color: .secondaryLabel, lines: 0)
    private let genderTitleLabel = CustomLabel(fontSize: 18, weight: .semibold, color: .label)
    private let genderLabel = CustomLabel(fontSize: 18, color: .secondaryLabel)
    
    private lazy var infoStackView: UIStackView = {
        let locationStack = UIStackView(arrangedSubviews: [locationTitleLabel, locationLabel])
        locationStack.axis = .vertical
        locationStack.spacing = 8
        locationStack.alignment = .leading
        
        let originStack = UIStackView(arrangedSubviews: [originTitleLabel, originLabel])
        originStack.axis = .vertical
        originStack.spacing = 8
        originStack.alignment = .leading
        
        let genderStack = UIStackView(arrangedSubviews: [genderTitleLabel, genderLabel])
        genderStack.axis = .vertical
        genderStack.spacing = 8
        genderStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [locationStack, originStack, genderStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .leading
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let headerStack = UIStackView(arrangedSubviews: [nameLabel, statusLabel, speciesLabel])
        headerStack.axis = .vertical
        headerStack.spacing = 12
        headerStack.alignment = .center
        
        let stack = UIStackView(arrangedSubviews: [characterImage, headerStack, infoStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.pinToEdges(of: view)
        
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),
            
            characterImage.heightAnchor.constraint(equalTo: characterImage.widthAnchor),
            characterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            
            infoStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
    
    private func configureUI() {
        title = character.name
        
        nameLabel.text = character.name
        statusLabel.text = character.status?.rawValue
        speciesLabel.text = character.species?.rawValue
        
        locationTitleLabel.text = "Last Known Location:"
        locationLabel.text = character.location?.name
        
        originTitleLabel.text = "Origin:"
        originLabel.text = character.origin?.name
        
        genderTitleLabel.text = "Gender:"
        genderLabel.text = character.gender?.rawValue
        
        characterImage.loadImage(from: character.image ?? "")
    }
}
