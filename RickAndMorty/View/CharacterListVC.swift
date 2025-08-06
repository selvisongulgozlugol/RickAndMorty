import Foundation
import UIKit
import SDWebImage

class CharacterListVC: UIViewController {
    
    // MARK: -Properties
    public var viewModel: RickAndMortyVM
    private var characters: [Character] = []
    private var isLoading = false
    private var isTableView = true
    
    init(viewModel: RickAndMortyVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: "CharacterListCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterGridCell.self, forCellWithReuseIdentifier: "CharacterGridCell")
        collectionView.backgroundColor = .systemBackground
        collectionView.isHidden = true
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
        
        
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    
    
    @objc private func toggleViewStyle(){
        isTableView.toggle()
        tableView.isHidden = !isTableView
        collectionView.isHidden = isTableView
        
        let imageName = isTableView ? "square.grid.2x2" : "list.bullet"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
}

// MARK: - onUpdateCharacter Delegate
extension CharacterListVC: RickAndMortyVMOutput {
    func onCharactersUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.collectionView.reloadData()
        }
    }
}
