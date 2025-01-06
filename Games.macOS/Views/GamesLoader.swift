import Foundation

extension FileManager {
    func verifyGamesFolder() {
        let gamesDirectoryPath = "/Users/michaelventimiglia/Library/Mobile Documents/com~apple~CloudDocs/Media/Games"
        
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
        let gamesDirectoryPath = "/Users/michaelventimiglia/Library/Mobile Documents/com~apple~CloudDocs/Media/Games"
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
}
