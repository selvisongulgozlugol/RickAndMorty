import Foundation
import Alamofire

enum NetworkError : Error {
    case invailURL
    case invailResponse
    case decodingError
    
    var localizedDescription : String {
        switch self{
        case .invailURL:
            return "Geçersiz URL"
        case .invailResponse:
            return "Geçersiz istek"
        case .decodingError:
            return "Çözümleme hatası"
        }
    }
}

class RickAndMortyService{
    
    static let shared: RickAndMortyService = RickAndMortyService()
    private init(){}
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    func downloadCharacters() async throws -> APIResponse {
        guard let url = URL(string: baseUrl + "character") else {
            throw NetworkError.invailURL
        }
        
        let data = AF.request(url).serializingDecodable(APIResponse.self)
        
        do {
            let response = try await data.value
            return response
        }
        catch {
            throw NetworkError.decodingError
        }
    }
    
   //Kontrol edilecek -parametre-
    func searchCharacter(parametres: [String: String]) async throws -> APIResponse{
        
        let url = baseUrl + "character"
        
        let data = AF.request(url, parameters: parametres).serializingDecodable(APIResponse.self)
        
        do {
            let response = try await data.value
            return response
        }
        catch {
            throw NetworkError.decodingError
        }
        
    }
}

