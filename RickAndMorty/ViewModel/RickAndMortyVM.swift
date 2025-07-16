import Foundation

class RickAndMortyVM {
    
    private(set) var characters: [Character] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    var onCharactersUpdated: (() -> Void)?
    
    private let service = RickAndMortyService.shared
    
    
    func downloadCharacters() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await service.downloadCharacters()
                await MainActor.run {
                    self.characters = response.results ?? [] 
                    self.isLoading = false
                    self.onCharactersUpdated?()
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Bir hata oluştu: \(error.localizedDescription)"
                    self.isLoading = false
                    self.onCharactersUpdated?()
                }
            }
        }
    }
    
    //Kontrol edilecek
    func filterCharacter(with query: String) {
        guard !query.isEmpty else {
            downloadCharacters()
            return
        }
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await service.searchCharacter(parametres: ["name" : query])
                await MainActor.run {
                    self.characters = response.results ?? []
                    self.isLoading = false
                    self.onCharactersUpdated?()
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Arama yapılırken hata oluştu: \(error.localizedDescription)"
                    self.isLoading = false
                    self.onCharactersUpdated?()
                }
            }
        }
    }
}

