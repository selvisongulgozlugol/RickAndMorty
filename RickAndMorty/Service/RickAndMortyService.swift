import Foundation

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

class RickAndMortyService {
    static let shared = RickAndMortyService()
    private init(){}
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    func downloadCharacters() async throws -> APIResponse {
        guard let url = URL(string: baseUrl + "character") else {
            throw NetworkError.invailURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let result = try JSONDecoder().decode(APIResponse.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func searchCharacters(query: String) async throws -> APIResponse {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: baseUrl + "character/?name=\(encodedQuery)") else {
            throw NetworkError.invailURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let result = try JSONDecoder().decode(APIResponse.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func filterCharacters(status: String) async throws -> APIResponse {
        guard let encodedStatus = status.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: baseUrl + "character/?status=\(encodedStatus)") else {
            throw NetworkError.invailURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let result = try JSONDecoder().decode(APIResponse.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError
        }
    }
}


