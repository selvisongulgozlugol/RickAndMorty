import Foundation

// MARK: - Character Update Protocol
protocol RickAndMortyVMOutput: AnyObject {
    func onCharactersUpdated()
}

class RickAndMortyVM {
    
    // MARK: - Delegate
    weak var output: RickAndMortyVMOutput?
    
    private var allCharacters: [Character] = []
    private(set) var characters: [Character] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    private let service: RickAndServiceProtocol
    
    init(service: RickAndServiceProtocol){
        self.service = service
    }
    
    func downloadCharacters() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await service.downloadCharacters()
                await MainActor.run {
                    self.allCharacters = response.results ?? []
                    self.characters = self.allCharacters
                    self.isLoading = false
                    self.output?.onCharactersUpdated()
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Bir hata oluştu: \(error.localizedDescription)"
                    self.isLoading = false
                    self.output?.onCharactersUpdated()
                }
            }
        }
    }
    
    
    func filterCharacter(with query: String) {
        guard !query.isEmpty else {
            characters = allCharacters
            output?.onCharactersUpdated()
            return
        }
        
        let lowercasedQuery = query.lowercased()
        characters = allCharacters.filter { character in
            character.name?.lowercased().contains(lowercasedQuery) == true
        }
        output?.onCharactersUpdated()
    }
}

