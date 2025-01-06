import Foundation
import SQLite

extension FileManager {
    func verifyGamesFolder() {
        let gamesDirectoryPath = "/Users/[name]/Library/Mobile Documents/com~apple~CloudDocs/Media/Games"
        
        if !fileExists(atPath: gamesDirectoryPath) {
            return
        }

        do {
            let platformFolders = try contentsOfDirectory(atPath: gamesDirectoryPath)
            
            for platformFolder in platformFolders {
                let platformFolderPath = gamesDirectoryPath.appending("/\(platformFolder)")
                
                if !fileExists(atPath: platformFolderPath) {
                    continue
                }
                
                do {
                    _ = try contentsOfDirectory(atPath: platformFolderPath)
                } catch {
                    print("Error reading contents of platform folder \(platformFolderPath): \(error)")
                }
            }
        } catch {
            print("Error reading contents of games directory: \(error)")
        }
    }
    
    func scanGamesFolder() -> [Game] {
        let gamesDirectoryPath = "/Users/[name]/Library/Mobile Documents/com~apple~CloudDocs/Media/Games"
        var games = [Game]()
        
        if !fileExists(atPath: gamesDirectoryPath) {
            return games
        }
        
        do {
            let platformFolders = try contentsOfDirectory(atPath: gamesDirectoryPath)
            
            for platformFolder in platformFolders {
                let platformFolderPath = gamesDirectoryPath.appending("/\(platformFolder)")
                
                do {
                    let gameFiles = try contentsOfDirectory(atPath: platformFolderPath)
                    
                    for gameFile in gameFiles {
                        let gameName = gameFile
                            .replacingOccurrences(of: ".iso", with: "")
                            .replacingOccurrences(of: ".sfc", with: "")
                            .replacingOccurrences(of: ".z64", with: "")
                            .replacingOccurrences(of: ".rvz", with: "")
                            .replacingOccurrences(of: ".gbc", with: "")
                            .replacingOccurrences(of: ".gba", with: "")
                            .replacingOccurrences(of: ".gb", with: "")
                            .replacingOccurrences(of: ".nds", with: "")
                            .replacingOccurrences(of: ".md", with: "")
                            .replacingOccurrences(of: ".chd", with: "")
                        
                        let game = Game(
                            name: gameName,
                            imageName: gameName,
                            filePath: platformFolderPath.appending("/\(gameFile)"),
                            platform: platformFolder,
                            description: "No Description",
                            releaseDate: "",
                            genres: "Unknown",
                            developers: "Unknown",
                            publishers: "Unknown",
                            esrbRating: "Unknown",
                            lastPlayedDate: "",
                            favorited: false,
                            multiplayer: false,
                            online: false,
                            downloaded: false,
                            broken: false,
                            achievements: "No Achievements"
                        )
                        games.append(game)
                    }
                } catch {
                    print("Error reading contents of platform folder \(platformFolderPath): \(error)")
                }
            }
        } catch {
            print("Error reading contents of games directory: \(error)")
        }
        
        return games
    }

    func fetchAllGames() -> [Game] {
        var games = [Game]()
        do {
            for row in try DatabaseManager.shared.db.prepare(DatabaseManager.shared.gamesTable) {
                let game = Game(
                    id: row[DatabaseManager.shared.id],
                    name: row[DatabaseManager.shared.name],
                    imageName: row[DatabaseManager.shared.imageName],
                    filePath: row[DatabaseManager.shared.filePath],
                    platform: row[DatabaseManager.shared.platform],
                    description: row[DatabaseManager.shared.description],
                    releaseDate: row[DatabaseManager.shared.releaseDate],
                    genres: row[DatabaseManager.shared.genres],
                    developers: row[DatabaseManager.shared.developers],
                    publishers: row[DatabaseManager.shared.publishers],
                    esrbRating: row[DatabaseManager.shared.esrbRating],
                    lastPlayedDate: row[DatabaseManager.shared.lastPlayedDate],
                    favorited: row[DatabaseManager.shared.favorited],
                    multiplayer: row[DatabaseManager.shared.multiplayer],
                    online: row[DatabaseManager.shared.online],
                    downloaded: row[DatabaseManager.shared.downloaded],
                    broken: row[DatabaseManager.shared.broken],
                    achievements: row[DatabaseManager.shared.achievements]
                )
                games.append(game)
            }
        } catch {
            print("Unable to fetch all games: \(error)")
        }
        return games
    }

    func fetchGamesBySearchQuery(_ query: String) -> [Game] {
        var games = [Game]()
        do {
            let searchQuery = "%" + query + "%"
            for row in try DatabaseManager.shared.db.prepare(DatabaseManager.shared.gamesTable.filter(DatabaseManager.shared.name.like(searchQuery)).order(DatabaseManager.shared.name.asc)) {
                let game = Game(
                    id: row[DatabaseManager.shared.id],
                    name: row[DatabaseManager.shared.name],
                    imageName: row[DatabaseManager.shared.imageName],
                    filePath: row[DatabaseManager.shared.filePath],
                    platform: row[DatabaseManager.shared.platform],
                    description: row[DatabaseManager.shared.description],
                    releaseDate: row[DatabaseManager.shared.releaseDate],
                    genres: row[DatabaseManager.shared.genres],
                    developers: row[DatabaseManager.shared.developers],
                    publishers: row[DatabaseManager.shared.publishers],
                    esrbRating: row[DatabaseManager.shared.esrbRating],
                    lastPlayedDate: row[DatabaseManager.shared.lastPlayedDate],
                    favorited: row[DatabaseManager.shared.favorited],
                    multiplayer: row[DatabaseManager.shared.multiplayer],
                    online: row[DatabaseManager.shared.online],
                    downloaded: row[DatabaseManager.shared.downloaded],
                    broken: row[DatabaseManager.shared.broken],
                    achievements: row[DatabaseManager.shared.achievements]
                )
                games.append(game)
            }
        } catch {
            print("Unable to fetch games by search query: \(error)")
        }
        return games
    }

    func fetchGamesByPlatform(_ platform: String) -> [Game] {
        var games = [Game]()
        do {
            for row in try DatabaseManager.shared.db.prepare(DatabaseManager.shared.gamesTable.filter(DatabaseManager.shared.platform == platform)) {
                let game = Game(
                    id: row[DatabaseManager.shared.id],
                    name: row[DatabaseManager.shared.name],
                    imageName: row[DatabaseManager.shared.imageName],
                    filePath: row[DatabaseManager.shared.filePath],
                    platform: row[DatabaseManager.shared.platform],
                    description: row[DatabaseManager.shared.description],
                    releaseDate: row[DatabaseManager.shared.releaseDate],
                    genres: row[DatabaseManager.shared.genres],
                    developers: row[DatabaseManager.shared.developers],
                    publishers: row[DatabaseManager.shared.publishers],
                    esrbRating: row[DatabaseManager.shared.esrbRating],
                    lastPlayedDate: row[DatabaseManager.shared.lastPlayedDate],
                    favorited: row[DatabaseManager.shared.favorited],
                    multiplayer: row[DatabaseManager.shared.multiplayer],
                    online: row[DatabaseManager.shared.online],
                    downloaded: row[DatabaseManager.shared.downloaded],
                    broken: row[DatabaseManager.shared.broken],
                    achievements: row[DatabaseManager.shared.achievements]
                )
                games.append(game)
            }
        } catch {
            print("Unable to fetch games by platform: \(error)")
        }
        return games
    }

    func fetchGameByName(_ gameName: String) -> Game? {
        do {
            if let row = try DatabaseManager.shared.db.pluck(DatabaseManager.shared.gamesTable.filter(DatabaseManager.shared.name == gameName)) {
                return Game(
                    id: row[DatabaseManager.shared.id],
                    name: row[DatabaseManager.shared.name],
                    imageName: row[DatabaseManager.shared.imageName],
                    filePath: row[DatabaseManager.shared.filePath],
                    platform: row[DatabaseManager.shared.platform],
                    description: row[DatabaseManager.shared.description],
                    releaseDate: row[DatabaseManager.shared.releaseDate],
                    genres: row[DatabaseManager.shared.genres],
                    developers: row[DatabaseManager.shared.developers],
                    publishers: row[DatabaseManager.shared.publishers],
                    esrbRating: row[DatabaseManager.shared.esrbRating],
                    lastPlayedDate: row[DatabaseManager.shared.lastPlayedDate],
                    favorited: row[DatabaseManager.shared.favorited],
                    multiplayer: row[DatabaseManager.shared.multiplayer],
                    online: row[DatabaseManager.shared.online],
                    downloaded: row[DatabaseManager.shared.downloaded],
                    broken: row[DatabaseManager.shared.broken],
                    achievements: row[DatabaseManager.shared.achievements]
                )
            }
        } catch {
            print("Unable to fetch game by name: \(error)")
        }
        return nil
    }
}
