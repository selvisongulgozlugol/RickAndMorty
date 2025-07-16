import Foundation

struct APIResponse: Decodable {
    let info: Info?
    let results: [Character]?
}

struct Info: Decodable {
    let count: Int
    let pages:Int
    let prev: String?
    let next: String?
}

struct Character: Decodable {
    let id: Int?
    let name: String?
    let status: CharacterStatus?
    let species: CharacterSpecies?
    let type: String?
    let gender: CharacterGender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum CharacterSpecies: String, Decodable {
    case alien = "Alien"
    case human = "Human"
}

enum CharacterStatus: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Decodable {
    let name: String
    let url: String
}
