import Foundation

class RickAndMortyBuilder {
    
    static let shared = RickAndMortyBuilder()
    private init(){}
    
    private lazy var networkService: NetworkServiceProtocol = {
        return NetworkService.shared
    }()
    
    private lazy var rickAndService: RickAndServiceProtocol = {
        return RickAndMortyService(networkService: networkService)
    }()
    
    func buildRickAndMortyService() -> RickAndServiceProtocol {
        return rickAndService
    }
    
    func buildRickAndMortyViewModel() -> RickAndMortyVM {
        return RickAndMortyVM(service: rickAndService)
    }}
