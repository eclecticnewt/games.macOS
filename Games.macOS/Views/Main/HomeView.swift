import SwiftUI

struct HomeView: View {
    @Binding var games: [Game]
    @Binding var selectedGameId: Int?
    @Binding var selectedPlatform: String?
    @Binding var searchText: String
    @Binding var selectedButton: String?
    
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
    @AppStorage("layoutStyle") private var layoutStyle: String = "Grid"
    
    @State private var homeViewVisibility: [String: Bool] = UserDefaults.standard.dictionary(forKey: "homeViewVisibility") as? [String: Bool] ?? [:]
    @State private var gameViewOrder: [String: Int] = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [:]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if games.isEmpty {
                    Text("No games to display")
                        .font(.headline)
                        .padding()
                } else {
                    ForEach(sortedGameViews(), id: \.self) { view in
                        if homeViewVisibility[view] ?? true {
                            switch view {
                            case "Recently Played":
                                RecentGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedRecentGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Favorites":
                                FavoriteGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Newly Added":                                
                                NewGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Random":
                                RandomGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Multiplayer":
                                MultiplayerGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Online":                                
                                OnlineGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Downloads":
                                DownloadGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Broken":                                
                                BrokenGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            case "Saves":                                
                                SaveGamesCarouselView(
                                    games: $games,
                                    selectedGameId: $selectedFavoriteGameId,
                                    selectedPlatform: $selectedPlatform,
                                    searchText: $searchText,
                                    selectedButton: $selectedButton,
                                    commonSelectedGameId: $selectedGameId,
                                    selectedBrokenGameId: $selectedBrokenGameId,
                                    selectedDownloadGameId: $selectedDownloadGameId,
                                    selectedFavoriteGameId: $selectedFavoriteGameId,
                                    selectedMultiplayerGameId: $selectedMultiplayerGameId,
                                    selectedNewGameId: $selectedNewGameId,
                                    selectedOnlineGameId: $selectedOnlineGameId,
                                    selectedPlatformGameId: $selectedPlatformGameId,
                                    selectedRandomGameId: $selectedRandomGameId,
                                    selectedRecentGameId: $selectedRecentGameId,
                                    selectedSearchGameId: $selectedSearchGameId
                                )
                                .frame(maxWidth: .infinity, alignment: .top)
                                .padding(.bottom, 180)
                            default:
                                EmptyView() // Handle other cases similarly
                            }
                        }
                    }
                }
                Spacer() // Add a spacer to push the last view up
            }
        }
        .onAppear {
            loadSettings()
        }
        .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
            loadSettings()
        }
    }
    
    private func sortedGameViews() -> [String] {
        return gameViewOrder.sorted(by: { $0.value < $1.value }).map { $0.key }
    }

    private func loadSettings() {
        homeViewVisibility = UserDefaults.standard.dictionary(forKey: "homeViewVisibility") as? [String: Bool] ?? [:]
        gameViewOrder = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [:]
    }
}
