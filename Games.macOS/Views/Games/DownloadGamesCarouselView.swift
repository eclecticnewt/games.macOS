import SwiftUI

struct DownloadGamesCarouselView: View {
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

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("sortOption") private var sortOption: String = "Title"

    var downloadGames: [Game] {
        var filtered = games.filter { $0.downloaded }
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

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Download Games")
                .foregroundColor(isDarkMode ? .white : .black)
                .font(.title)
                .bold()
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)

            if !downloadGames.isEmpty {
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: self.spacing) {
                            ForEach(downloadGames.indices, id: \.self) { index in
                                let game = downloadGames[index]
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
                Text("No download games available.")
                    .font(.title2)
                    .foregroundColor(isDarkMode ? .white : .gray)
                    .multilineTextAlignment(.center)  // Ensure multi-line text is centered
                    .frame(maxWidth: .infinity, alignment: .center)  // Center the text horizontally
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            loadDownloadGames()
            resetSelections()
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

    private func loadDownloadGames() {
        games = DatabaseManager.shared.fetchAllGames()
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
