import Foundation
import UIKit
import SDWebImage

class CharacterListVC: UIViewController {
    
    // MARK: -Properties
    private var characters: [Character] = []
    private var isLoading = false
    
    private let viewModel = RickAndMortyVM()
    private var isTableView = true
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        setupBindings()
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
        //searchController.searchResultsUpdater = self
        //searchController.searchBar.delegate = self
    }
    
    private func setupBindings() {
        viewModel.onCharactersUpdated = { [weak self] in
            DispatchQueue.main.async{
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc private func toggleViewStyle(){
        isTableView.toggle()
        tableView.isHidden = !isTableView
        collectionView.isHidden = isTableView
        
        let imageName = isTableView ? "square.grid.2x2" : "list.bullet"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
}


// MARK: - UIImageView
extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        self.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: "placeholder"),
            options: [.retryFailed, .continueInBackground],
            completed: nil
        )
    }
}

// MARK: - TableView
extension CharacterListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell", for: indexPath) as? CharacterListCell else {
            return UITableViewCell()
        }
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

extension CharacterListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = viewModel.characters[indexPath.row]
        let detailsVC = CharacterDetailsVC(character: character)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - CollectionView
extension CharacterListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        let detailsVC = CharacterDetailsVC(character: character)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension CharacterListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterGridCell", for: indexPath) as? CharacterGridCell else {
            return UICollectionViewCell()
        }
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}
    
extension CharacterListVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
}
    /*
     extension CharacterListVC: UISearchResultsUpdating, UISearchBarDelegate {
     func updateSearchResults(for searchController: UISearchController) {
     guard let searchText = searchController.searchBar.text else { return }
     //viewModel.searchCharacters(with: searchText)
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     viewModel.downloadCharacters()
     }
     }
     */
    
