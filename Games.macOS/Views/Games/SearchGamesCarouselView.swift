import SwiftUI

struct SearchGamesCarouselView: View {
    @Binding var games: [Game]
    @Binding var selectedGameId: Int?
    @Binding var selectedPlatform: String?
    @Binding var searchText: String
    @Binding var selectedButton: String?
    @State private var tileWidth: CGFloat = 150
    @State private var spacing: CGFloat = 10
    @State private var geometryWidth: CGFloat = 0
    @Binding var commonSelectedGameId: Int?
    @Binding var selectedBrokenGameId: Int?
    @Binding var selectedDownloadGameId: Int?
    @Binding var selectedFavoriteGameId: Int?
    @Binding var selectedMultiplayerGameId: Int?
    @Binding var selectedNewGameId: Int?
    @Binding var selectedOnlineGameId: Int?
    @Binding var selectedPlatformGameId: Int?
    @Binding var selectedRandomGameId: Int?
    @Binding var selectedRecentGameId: Int?
    @Binding var selectedSearchGameId: Int?
    @Binding var isOnScreenKeyboard: Bool
    @FocusState.Binding var isSearchBarFocused: Bool

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("sortOption") private var sortOption: String = "Title"

    // AppStorage bindings for searchable fields
    @AppStorage("searchByTitle") private var searchByTitle: Bool = false
    @AppStorage("searchByCharacter") private var searchByCharacter: Bool = false
    @AppStorage("searchByDescription") private var searchByDescription: Bool = false
    @AppStorage("searchByDeveloper") private var searchByDeveloper: Bool = false
    @AppStorage("searchByPublisher") private var searchByPublisher: Bool = false

    var filteredGames: [Game] {
        if searchText.isEmpty {
            return []
        } else {
            var filtered = games.filter { game in
                var matches = false
                if searchByTitle {
                    matches = matches || game.name.lowercased().contains(searchText.lowercased())
                }
    //            if searchByCharacter {
    //                matches = matches || game.character.lowercased().contains(searchText.lowercased())
    //            }
                if searchByDescription {
                    matches = matches || game.description.lowercased().contains(searchText.lowercased())
                }
                if searchByDeveloper {
                    matches = matches || game.developers.lowercased().contains(searchText.lowercased())
                }
                if searchByPublisher {
                    matches = matches || game.publishers.lowercased().contains(searchText.lowercased())
                }
                return matches
            }

            // Apply sorting based on sortOption
            switch sortOption {
            case "Title":
                filtered.sort { $0.name < $1.name }
            case "Release Date":
                filtered.sort { $0.releaseDate < $1.releaseDate }
            case "Last Played Date":
                filtered.sort { $0.lastPlayedDate > $1.lastPlayedDate }
            case "Favorited":
                filtered.sort { $0.favorited && !$1.favorited }
            default:
                break
            }

            return filtered
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(searchText.isEmpty ? "Search Games" : "Search Games Containing")
                    .foregroundColor(isDarkMode ? .white : .black)
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                    .padding(.top, 10)
                Text(searchText)
                    .foregroundColor(Color.gray)
                    .font(.title)
                    .italic()
                    .bold()
                    .padding(.leading, 5)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if searchText.isEmpty {
                Spacer()
                Text("Search for a game.")
                    .font(.title2)
                    .foregroundColor(isDarkMode ? .white : .gray)
                    .multilineTextAlignment(.center)  // Ensure multi-line text is centered
                    .frame(maxWidth: .infinity, alignment: .center)  // Center the text horizontally
                    .padding()
                Spacer()
            } else if !filteredGames.isEmpty {
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: self.spacing) {
                            ForEach(filteredGames.indices, id: \.self) { index in
                                let game = filteredGames[index]
                                GameTileView(
                                    game: game,
                                    isSelected: selectedGameId == game.id,
                                    onTap: {
                                        handleSelection(for: game)
                                    },
                                    isDarkMode: isDarkMode
                                )
                                .frame(width: tileWidth, height: tileWidth)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                    .onChange(of: geometry.size.width) { newWidth in
                        self.geometryWidth = newWidth
                        self.calculateTileSize(with: geometry.size.width)
                    }
                    .onAppear {
                        self.geometryWidth = geometry.size.width
                        self.calculateTileSize(with: geometry.size.width)
                    }
                }
            } else {
                Spacer()
                Text("No games available matching your search.")
                    .font(.title2)
                    .foregroundColor(isDarkMode ? .white : .gray)
                    .multilineTextAlignment(.center)  // Ensure multi-line text is centered
                    .frame(maxWidth: .infinity, alignment: .center)  // Center the text horizontally
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            resetSelections()
        }

        if isOnScreenKeyboard {
            KeyboardCarouselView(searchText: $searchText)
                .padding(20)
//                .frame(width: .infinity, height: 300)
        }
    }

    private func handleSelection(for game: Game) {
        if selectedGameId == game.id {
            selectedGameId = nil
            commonSelectedGameId = nil
        } else {
            selectedGameId = game.id
            commonSelectedGameId = game.id
            resetOtherSelections()
        }
    }

    private func calculateTileSize(with width: CGFloat) {
        let availableWidth = width - 40
        let minSpacing: CGFloat = 10
        let idealTileWidth: CGFloat = 150

        let numberOfTiles = floor(availableWidth / (idealTileWidth + minSpacing))
        let totalSpacing = minSpacing * (numberOfTiles - 1)
        let calculatedTileWidth = (availableWidth - totalSpacing) / numberOfTiles

        self.tileWidth = min(calculatedTileWidth, idealTileWidth)
        self.spacing = (availableWidth - (self.tileWidth * numberOfTiles)) / (numberOfTiles - 1)
    }

    private func resetSelections() {
        selectedPlatform = nil
        searchText = ""
        selectedGameId = nil
    }

    private func resetOtherSelections() {
        selectedBrokenGameId = nil
        selectedDownloadGameId = nil
        selectedFavoriteGameId = nil
        selectedMultiplayerGameId = nil
        selectedNewGameId = nil
        selectedOnlineGameId = nil
        selectedPlatformGameId = nil
        selectedRandomGameId = nil
        selectedRecentGameId = nil
        selectedSearchGameId = nil
    }
}
