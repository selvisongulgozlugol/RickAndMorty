
//MARK: - Error

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

