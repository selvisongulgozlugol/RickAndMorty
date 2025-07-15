import Foundation

struct APIResponse : Codable {
    let info : Info
    let results : [Character]
}

struct Info : Codable {
    let count : Int
    let pages :Int
    let prev : String?
    let next : String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: CharacterSpecies
    let type: String
    let gender: CharacterGender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum CharacterSpecies: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url: String
}
