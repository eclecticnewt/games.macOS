import SwiftUI

struct GamesCarouselView: View {
    
    @Binding var games: [Game]
    @Binding var selectedPlatform: String?
    @Binding var searchText: String
    @Binding var selectedButton: String?
    @FocusState var isSearchBarFocused: Bool
    @Binding var isSidebarVisible: Bool
    @Binding var showDetails: Bool
    @Binding var showDetailsSheet: Bool
    @Binding var selectedGameId: Int?
    
    // Separate selected game states for each view
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
    @AppStorage("isOnScreenKeyboard") private var isOnScreenKeyboard: Bool = false
    
    var body: some View {
        if selectedPlatform != nil {
            PlatformGamesCarouselView(
                games: $games,
                selectedPlatform: $selectedPlatform,
                selectedGameId: $selectedGameId,
                searchText: $searchText, selectedButton: $selectedButton,
                commonSelectedGameId: $selectedGameId,
                selectedBrokenGameId: $selectedBrokenGameId,
                selectedDownloadGameId: $selectedDownloadGameId,
                selectedFavoriteGameId: $selectedFavoriteGameId,
                selectedMultiplayerGameId: $selectedMultiplayerGameId,
                selectedNewGameId: $selectedNewGameId,
                selectedOnlineGameId: $selectedOnlineGameId, selectedPlatformGameId: $selectedPlatformGameId,
                selectedRandomGameId: $selectedRandomGameId,
                selectedRecentGameId: $selectedRecentGameId,
                selectedSearchGameId: $selectedSearchGameId
            )
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.bottom, 20)
        } else if selectedButton == "Search" {
            SearchGamesCarouselView(games: $games, selectedGameId: $selectedGameId, selectedPlatform: $selectedPlatform, searchText: $searchText, selectedButton: $selectedButton, commonSelectedGameId: $commonSelectedGameId, selectedBrokenGameId: $selectedBrokenGameId, selectedDownloadGameId: $selectedDownloadGameId, selectedFavoriteGameId: $selectedFavoriteGameId, selectedMultiplayerGameId: $selectedMultiplayerGameId, selectedNewGameId: $selectedNewGameId, selectedOnlineGameId: $selectedOnlineGameId, selectedPlatformGameId: $selectedPlatformGameId, selectedRandomGameId: $selectedRandomGameId, selectedRecentGameId: $selectedRecentGameId, selectedSearchGameId: $selectedSearchGameId, isOnScreenKeyboard: $isOnScreenKeyboard, isSearchBarFocused: $isSearchBarFocused
            )
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.bottom, 20)
        } else if selectedButton == "Recently Played" {
            RecentGamesCarouselView(
                games: $games,
                selectedGameId: $selectedRecentGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Favorites" {
            FavoriteGamesCarouselView(
                games: $games,
                selectedGameId: $selectedFavoriteGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Newly Added" {
            NewGamesCarouselView(
                games: $games,
                selectedGameId: $selectedNewGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Random" {
            RandomGamesCarouselView(
                games: $games,
                selectedGameId: $selectedGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Multiplayer" {
            MultiplayerGamesCarouselView(
                games: $games,
                selectedGameId: $selectedGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Online" {
            OnlineGamesCarouselView(
                games: $games,
                selectedGameId: $selectedGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Downloads" {
            DownloadGamesCarouselView(
                games: $games,
                selectedGameId: $selectedGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
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
            .padding(.bottom, 20)
        } else if selectedButton == "Broken" {
            BrokenGamesCarouselView(
                games: $games,
                selectedGameId: $selectedGameId,
                selectedPlatform: $selectedPlatform,
                searchText: $searchText, selectedButton: $selectedButton,
                commonSelectedGameId: $selectedGameId, selectedBrokenGameId: $selectedBrokenGameId,
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
            .padding(.bottom, 20)
        }
    }
}
