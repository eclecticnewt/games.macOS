import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    public var db: Connection!
    let gamesTable = Table("games")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let imageName = Expression<String>("imageName")
    let filePath = Expression<String>("filePath")
    let platform = Expression<String>("platform")
    let description = Expression<String>("description")
    let releaseDate = Expression<String>("releaseDate")
    let genres = Expression<String>("genres")
    let developers = Expression<String>("developers")
    let publishers = Expression<String>("publishers")
    let esrbRating = Expression<String>("esrbRating")
    let lastPlayedDate = Expression<String>("lastPlayedDate")
    let favorited = Expression<Bool>("favorited")
    let multiplayer = Expression<Bool>("multiplayer")
    let online = Expression<Bool>("online")
    let downloaded = Expression<Bool>("downloaded")
    let broken = Expression<Bool>("broken")
    let achievements = Expression<String>("achievements")

    private init() {
        setupDatabase()
    }

    private func setupDatabase() {
        let databasePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("games.sqlite3")
        do {
            db = try Connection(databasePath.path)
        } catch {
            print("Unable to setup database: \(error)")
        }
    }

    public func fetchAllGames() -> [Game] {
        return FileManager.default.fetchAllGames()
    }

    public func fetchGamesBySearchQuery(_ query: String) -> [Game] {
        return FileManager.default.fetchGamesBySearchQuery(query)
    }

    public func fetchGamesByPlatform(_ platform: String) -> [Game] {
        return FileManager.default.fetchGamesByPlatform(platform)
    }

    public func fetchGameByName(_ gameName: String) -> Game? {
        return FileManager.default.fetchGameByName(gameName)
    }

    public func updateGame(_ game: Game) {
        let gameToUpdate = gamesTable.filter(id == game.id)
        do {
            try db.run(gameToUpdate.update(
                name <- game.name,
                imageName <- game.imageName,
                filePath <- game.filePath,
                platform <- game.platform,
                description <- game.description,
                releaseDate <- game.releaseDate,
                genres <- game.genres,
                developers <- game.developers,
                publishers <- game.publishers,
                esrbRating <- game.esrbRating,
                lastPlayedDate <- game.lastPlayedDate,
                favorited <- game.favorited,
                multiplayer <- game.multiplayer,
                online <- game.online,
                downloaded <- game.downloaded,
                broken <- game.broken,
                achievements <- game.achievements
            ))
        } catch {
            print("Unable to update game: \(error)")
        }
    }

    public func updateLastPlayedDate(for game: Game) {
        let gameToUpdate = gamesTable.filter(id == game.id)
        let currentDateTime = ISO8601DateFormatter().string(from: Date())
        do {
            try db.run(gameToUpdate.update(lastPlayedDate <- currentDateTime))
        } catch {
            print("Unable to update last played date: \(error)")
        }
    }
}
