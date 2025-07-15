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
                    self.characters = response.results
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
    

    func searchCharacters(with query: String) {
        guard !query.isEmpty else {
            downloadCharacters()
            return
        }
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let response = try await service.searchCharacters(query: query)
                await MainActor.run {
                    self.characters = response.results
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
    func filterByStatus(_ status: CharacterStatus) {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let response = try await service.filterCharacters(status: status.rawValue)
                await MainActor.run {
                    self.characters = response.results
                    self.isLoading = false
                    self.onCharactersUpdated?()
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Filtreleme yapılırken hata oluştu: \(error.localizedDescription)"
                    self.isLoading = false
                    self.onCharactersUpdated?()
        }
      }
     }
    }
}
