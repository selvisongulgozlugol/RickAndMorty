import Foundation

//MARK: - Network Service

protocol NetworkServiceProtocol {
    func request<T : Decodable>(url: String, parameters: [String:String]?, responseType: T.Type) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private init(){}
    
    func request<T: Decodable>(url: String, parameters: [String : String]?, responseType: T.Type) async throws -> T {
        // Parameters varsa URL'e ekle
        var urlString = url
        if let parameters = parameters {
            let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlString += "?" + queryString
        }
        
        guard let finalURL = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: finalURL)
            let response = try JSONDecoder().decode(responseType, from: data)
            return response
        } catch {
            throw NetworkError.decodingError
        }
    }
}
