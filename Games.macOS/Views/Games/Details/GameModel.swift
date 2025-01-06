import SwiftUI

struct Game: Identifiable, Codable {
    let id: Int
    var name: String
    var filePath: String
    var imageName: String
    var platform: String
    var description: String
    var releaseDate: String
    var genres: String
    var developers: String
    var publishers: String
    var esrbRating: String
    var lastPlayedDate: String
    var favorited: Bool
    var multiplayer: Bool
    var online: Bool
    var downloaded: Bool
    var broken: Bool
    var achievements: String
    
    init(id: Int = Int(), name: String, imageName: String, filePath: String, platform: String, description: String, releaseDate: String, genres: String, developers: String, publishers: String, esrbRating: String, lastPlayedDate: String, favorited: Bool = false, multiplayer: Bool = false, online: Bool = false, downloaded: Bool = false, broken: Bool = false, achievements: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.filePath = filePath
        self.platform = platform
        self.description = description
        self.releaseDate = releaseDate
        self.genres = genres
        self.developers = developers
        self.publishers = publishers
        self.esrbRating = esrbRating
        self.lastPlayedDate = lastPlayedDate
        self.favorited = favorited
        self.multiplayer = multiplayer
        self.online = online
        self.downloaded = downloaded
        self.broken = broken
        self.achievements = achievements
    }
}
