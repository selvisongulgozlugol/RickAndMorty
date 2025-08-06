import Foundation
import Alamofire

//MARK: - Protocol
protocol RickAndServiceProtocol{
    func downloadCharacters() async throws -> APIResponse
    func searchCharacters(parameters: [String: String]) async throws -> APIResponse
}

//MARK: - RickAndMortyService
class RickAndMortyService : RickAndServiceProtocol {
    
    private let networkService : NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    struct urlString {
        private static let baseUrl = "https://rickandmortyapi.com/api/"
        static let characters = baseUrl + "character"
        static let episodes = baseUrl + "episode"
        static let locations = baseUrl + "location"
    }
    
    func downloadCharacters() async throws -> APIResponse {
        return try await networkService.request(url: urlString.characters, parameters: nil, responseType: APIResponse.self)
    }
    
    func searchCharacters(parameters: [String : String]) async throws -> APIResponse {
        return try await networkService.request(url: urlString.characters, parameters: parameters, responseType: APIResponse.self)
    }
}
