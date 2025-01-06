import SwiftUI
import Combine

class DatabaseViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var filteredGames: [Game] = []
    @Published var searchText: String = ""
    @Published var sortAscending: Bool = true

    let headers: [String] = [
        "id", "name", "imageName", "filePath", "platform", "description", "releaseDate",
        "genres", "developers", "publishers", "esrbRating", "lastPlayedDate", "favorited",
        "multiplayer", "online", "downloaded", "broken", "achievements"
    ]

    private var cancellables: Set<AnyCancellable> = []
    private var editedGames: [Int: Game] = [:]

    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.filterGames(by: searchText)
            }
            .store(in: &cancellables)
    }

    func loadGames() {
        DispatchQueue.global(qos: .background).async {
            let fetchedGames = DatabaseManager.shared.fetchAllGames()
            DispatchQueue.main.async {
                self.games = fetchedGames
                self.filteredGames = fetchedGames
            }
        }
    }

    func value(for column: String, in game: Game) -> String {
        switch column {
        case "id":
            return String(game.id)
        case "name":
            return game.name
        case "imageName":
            return game.imageName
        case "filePath":
            return game.filePath
        case "platform":
            return game.platform
        case "description":
            return game.description
        case "releaseDate":
            return game.releaseDate
        case "genres":
            return game.genres
        case "developers":
            return game.developers
        case "publishers":
            return game.publishers
        case "esrbRating":
            return game.esrbRating
        case "lastPlayedDate":
            return game.lastPlayedDate
        case "favorited":
            return game.favorited ? "Yes" : "No"
        case "multiplayer":
            return game.multiplayer ? "Yes" : "No"
        case "online":
            return game.online ? "Yes" : "No"
        case "downloaded":
            return game.downloaded ? "Yes" : "No"
        case "broken":
            return game.broken ? "Yes" : "No"
        case "achievements":
            return game.achievements
        default:
            return ""
        }
    }

    func filterGames(by query: String) {
        if query.isEmpty {
            filteredGames = games
        } else {
            filteredGames = games.filter {
                $0.name.lowercased().contains(query.lowercased()) ||
                $0.platform.lowercased().contains(query.lowercased())
            }
        }
    }

    func updateLocalValue(for column: String, with newValue: String, in index: Int) {
        var game = filteredGames[index]

        switch column {
        case "name":
            game.name = newValue
        case "imageName":
            game.imageName = newValue
        case "filePath":
            game.filePath = newValue
        case "platform":
            game.platform = newValue
        case "description":
            game.description = newValue
        case "releaseDate":
            game.releaseDate = newValue
        case "genres":
            game.genres = newValue
        case "developers":
            game.developers = newValue
        case "publishers":
            game.publishers = newValue
        case "esrbRating":
            game.esrbRating = newValue
        case "lastPlayedDate":
            game.lastPlayedDate = newValue
        case "favorited":
            game.favorited = (newValue.lowercased() == "yes")
        case "multiplayer":
            game.multiplayer = (newValue.lowercased() == "yes")
        case "online":
            game.online = (newValue.lowercased() == "yes")
        case "downloaded":
            game.downloaded = (newValue.lowercased() == "yes")
        case "broken":
            game.broken = (newValue.lowercased() == "yes")
        case "achievements":
            game.achievements = newValue
        default:
            break
        }

        filteredGames[index] = game
        games = filteredGames
        editedGames[game.id] = game
    }

    func saveAllChanges() {
        for (_, game) in editedGames {
            DatabaseManager.shared.updateGame(game)
        }
        editedGames.removeAll()
    }

    func columnWidth(for column: String) -> CGFloat {
        switch column {
        case "id":
            return 50
        case "name":
            return 150
        case "platform":
            return 120
        case "releaseDate":
            return 120
        case "genres":
            return 120
        case "developers":
            return 150
        case "publishers":
            return 150
        case "esrbRating":
            return 100
        case "lastPlayedDate":
            return 120
        case "favorited", "multiplayer", "online", "downloaded", "broken":
            return 100
        case "description":
            return 300
        case "imageName", "filePath":
            return 150
        case "achievements":
            return 200
        default:
            return 100
        }
    }
}
