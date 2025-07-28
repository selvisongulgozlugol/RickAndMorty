import Foundation

class RickAndMortyBuilder {
    
    static func generate() -> CharacterListVC {
        
        let networkService = NetworkService.shared
        let rickAndMortyService: RickAndServiceProtocol = RickAndMortyService(networkService: networkService)
        let viewModel = RickAndMortyVM(service: rickAndMortyService)
        let characterListVC = CharacterListVC()
        
        characterListVC.setViewModel(viewModel)
        
        return characterListVC
    }
}
