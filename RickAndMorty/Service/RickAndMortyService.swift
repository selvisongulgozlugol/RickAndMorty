import Foundation
import Alamofire

//MARK: - Protocol
protocol RickAndServiceProtocol{
    func downloadCharacters() async throws -> APIResponse
    func searchCharacters(parameters: [String: String]) async throws -> APIResponse
}

//MARK: - RickAndMortyService
class RickAndMortyService : RickAndServiceProtocol {
    
    //Singleton
    static let shared = RickAndMortyService()
   // private let baseUrl = "https://rickandmortyapi.com/api/"
    private let networkService : NetworkServiceProtocol
    private init(){
        self.networkService = NetworkService()
    }
    
    // Dependency injection için
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //URL
    struct urlString {
        private static let baseUrl = "https://rickandmortyapi.com/api/"
        static let characters = baseUrl + "character"
        static let episodes = baseUrl + "episode"
        static let locations = baseUrl + "location"
    }
    
    func downloadCharacters() async throws -> APIResponse {
        //let url = baseUrl + "character"
        return try await networkService.request(url: urlString.characters, parameters: nil, responseType: APIResponse.self)
    }
    
    func searchCharacters(parameters: [String : String]) async throws -> APIResponse {
        //let url = baseUrl + "character"
        return try await networkService.request(url: urlString.characters, parameters: parameters, responseType: APIResponse.self)
    }
}

    /*
    
    func performRequest(parameters: [String : String]?) async throws -> APIResponse{
        guard let url = URL(string: baseUrl + "character") else {
            throw NetworkError.invalidURL
        }
        
        let data = AF.request(url).serializingDecodable(APIResponse.self)
        
        do{
            let response = try await data.value
            return response
        }catch {
            throw NetworkError.decodingError
        }
    }
}

  */
    /*
    
    func downloadCharacters() async throws -> APIResponse {
        guard let url = URL(string: baseUrl + "character") else {
            throw NetworkError.invalidURL
        }
        
        let data = AF.request(url).serializingDecodable(APIResponse.self)
        
        /*
        guard let response = try? await data.value else {
            throw NetworkError.decodingError
        }
        return response
        */
        

        do {
            let response = try await data.value
            return response
        }
        catch {
            throw NetworkError.decodingError
        }
        
    }
    
   //Kontrol edilecek -parametre-
    func searchCharacters(parameters: [String: String]) async throws -> APIResponse{
        guard let url = URL(string: baseUrl + "character") else {
            throw NetworkError.invalidURL
        }
        
        let data = AF.request(url, parameters: parameters).serializingDecodable(APIResponse.self)
        
        do {
            let response = try await data.value
            return response
        } catch {
            throw NetworkError.decodingError
        }
    }
}


enum NetworkError : Error {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var localizedDescription : String {
        switch self{
        case .invalidURL:
            return "Geçersiz URL"
        case .invalidResponse:
            return "Geçersiz istek"
        case .decodingError:
            return "Çözümleme hatası"
        }
    }
}

*/
