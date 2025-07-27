import Foundation
import Alamofire

//MARK: - Network Service

protocol NetworkServiceProtocol {
    func request<T : Decodable>(url: String, parameters: [String:String]?, responseType: T.Type) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private init(){}
    
    func request<T: Decodable>(url: String, parameters: [String : String]?, responseType: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let response = try await AF.request(url, parameters: parameters).serializingDecodable(responseType).value
            return response
        } catch {
            throw NetworkError.decodingError
        }
    }
}
