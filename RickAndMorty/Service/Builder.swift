import Foundation
import UIKit

enum RickAndMortyBuilder {
    
    static func generate() -> UIViewController {
        let networkService = NetworkService.shared
        let rickAndMortyService: RickAndServiceProtocol = RickAndMortyService(networkService: networkService)
        let viewModel = RickAndMortyVM(service: rickAndMortyService)
        let characterListVC = CharacterListVC(viewModel: viewModel)
        
        return characterListVC
    }
}
