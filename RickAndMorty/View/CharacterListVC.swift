import Foundation
import UIKit
import SDWebImage

class CharacterListVC: UIViewController {
    
    // MARK: -Properties
    var viewModel: RickAndMortyVM
    private var isLoading = false
    private var isListLayout = true
    
    private var collectionViewManager: CharacterCollectionViewManager?
    
    init(viewModel: RickAndMortyVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeListLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterGridCell.self, forCellWithReuseIdentifier: "CharacterGridCell")
        collectionView.backgroundColor = .systemBackground
        collectionView.isHidden = false
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search Characters"
        controller.obscuresBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        return controller
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        viewModel.downloadCharacters()
    }
    
    private func setupUI(){
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        let toggleButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(toggleViewStyle))
        navigationItem.rightBarButtonItem = toggleButton
        
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDelegate(){
        // Collection View Manager
        collectionViewManager = CharacterCollectionViewManager(dataProvider: self, actionDelegate: self)
        collectionView.delegate = collectionViewManager
        collectionView.dataSource = collectionViewManager
        
        // Search delegates
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    private func makeListLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func makeGridLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
    
    @objc private func toggleViewStyle(){
        isListLayout.toggle()
        let newLayout = isListLayout ? makeListLayout() : makeGridLayout()
        collectionView.setCollectionViewLayout(newLayout, animated: true)
        
        let imageName = isListLayout ? "square.grid.2x2" : "list.bullet"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
}

// MARK: - CharacterCollectionViewDataProvider
extension CharacterListVC: CharacterCollectionViewDataProvider {
    var characters: [Character] {
        return viewModel.characters
    }
    
    func numberOfItems() -> Int {
        return viewModel.characters.count
    }
    
    func character(at index: Int) -> Character {
        return viewModel.characters[index]
    }
}

// MARK: - CharacterCollectionViewActionDelegate
extension CharacterListVC: CharacterCollectionViewActionDelegate {
    func didSelectCharacter(_ character: Character) {
        let detailsVC = CharacterDetailsVC(character: character)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func cellSize(for collectionView: UICollectionView) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}

// MARK: - RickAndMortyVMOutput
extension CharacterListVC: RickAndMortyVMOutput {
    func onCharactersUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
