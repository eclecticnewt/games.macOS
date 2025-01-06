import SwiftUI

struct ContentView: View {
    
    @State private var games: [Game] = []
    @State private var selectedPlatform: String? = nil
    @State private var searchText: String = ""
    @State private var selectedButton: String? = nil
    @FocusState private var isSearchBarFocused: Bool
    @State private var isSidebarVisible = false
    @State private var hasInitializedSidebar = false // Ensures initialization happens only once
    @State private var showDetails = false
    @State private var showDetailsSheet = false
    @State private var selectedGameId: Int? = nil

    // Separate selected game states for each view
    @State private var commonSelectedGameId: Int? = nil
    @State private var selectedBrokenGameId: Int? = nil
    @State private var selectedDownloadGameId: Int? = nil
    @State private var selectedFavoriteGameId: Int? = nil
    @State private var selectedMultiplayerGameId: Int? = nil
    @State private var selectedNewGameId: Int? = nil
    @State private var selectedOnlineGameId: Int? = nil
    @State private var selectedPlatformGameId: Int? = nil
    @State private var selectedRandomGameId: Int? = nil
    @State private var selectedRecentGameId: Int? = nil
    @State private var selectedSearchGameId: Int? = nil
    @AppStorage("layoutStyle") private var layoutStyle: String = "Grid"
    @AppStorage("fontSize") private var fontSize: Double = 12.0
    @AppStorage("tileSize") private var tileSize: Double = 20.0
    @AppStorage("showGameNameUnderTile") private var showGameNameUnderTile: Bool = true
    @AppStorage("buttonIconStyle") private var buttonIconStyle: String = "Letters"
    @AppStorage("isOnScreenKeyboard") private var isOnScreenKeyboard: Bool = false
    @AppStorage("isSidebarDefault") private var isSidebarDefault: Bool = false
    
    // AppStorage to sync with UserDefaults for dark mode
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    // Manage view visibility and order
    @State private var homeViewVisibility: [String: Bool] = UserDefaults.standard.dictionary(forKey: "homeViewVisibility") as? [String: Bool] ?? [:]
    @State private var gameViewOrder: [String: Int] = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [:]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                (isDarkMode ? Color.black : Color.white)
                    .edgesIgnoringSafeArea(.all)
                HStack(spacing: 0) {
                    if isSidebarVisible {
                        SidebarView(
                            searchText: $searchText,
                            isSearchBarFocused: $isSearchBarFocused,
                            selectedButton: $selectedButton,
                            selectedPlatform: $selectedPlatform,
                            selectedGameId: $selectedGameId
                        )
                        .frame(width: 250)
                        .background(isDarkMode ? Color(red: 0.24, green: 0.27, blue: 0.30).opacity(0.6) : Color.white)
                    }
                    VStack(spacing: 10) {
                        if !showDetails {
                            renderView()
                        }
                        Spacer()
                        ButtonsView(
                            isSidebarVisible: $isSidebarVisible,
                            searchText: $searchText,
                            selectedButton: $selectedButton,
                            selectedGameId: $selectedGameId,
                            showDetails: $showDetails,
                            showDetailsSheet: $showDetailsSheet,
                            games: games
                        )
                        .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(isDarkMode ? Color(red: 0.16, green: 0.18, blue: 0.19) : Color.white)
                }

                if showDetailsSheet, let selectedGame = games.first(where: { $0.id == selectedGameId }) {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showDetailsSheet = false
                        }

                    VStack {
                        GameDetailsView(game: selectedGame)
                            .background(isDarkMode ? Color.black : Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                            .onTapGesture {}
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
            .onAppear {
                initializeSidebar()
                verifyGamesFolder()
                loadGames()
                if selectedButton == nil {
                    selectedButton = "Home"  // Only set to Home if no button is selected
                }
            }
//            .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
//                loadSettings()
//            }
        }
        .id(isDarkMode) // Force view update when isDarkMode changes
        .id(isOnScreenKeyboard) // Force view update when isDarkMode changes
        .id(isSidebarDefault) // Force view update when isSidebarDefault changes
        .id(showGameNameUnderTile) // Force view update when showGameNameUnderTile changes
    }

    /// Initializes the sidebar visibility on first launch
    private func initializeSidebar() {
        if !hasInitializedSidebar {
            isSidebarVisible = isSidebarDefault
            hasInitializedSidebar = true
        }
    }

    @ViewBuilder
    private func renderView() -> some View {
        if selectedButton == "Settings" {
            SettingsView()
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 20)
                .padding(.bottom, 20)
        } else {
            PlatformsView(selectedGameId: $selectedGameId, selectedPlatform: $selectedPlatform, searchText: $searchText, isSearchBarFocused: $isSearchBarFocused, selectedButton: $selectedButton)
            if selectedButton == "Home" {
                HomeView(
                    games: $games,
                    selectedGameId: $selectedGameId,
                    selectedPlatform: $selectedPlatform,
                    searchText: $searchText,
                    selectedButton: $selectedButton,
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
                .padding(.top, 20)
                .padding(.bottom, 20)
            } else if layoutStyle == "Carousel" {
                GamesCarouselView(
                    games: $games,
                    selectedPlatform: $selectedPlatform,
                    searchText: $searchText,
                    selectedButton: $selectedButton,
                    isSidebarVisible: $isSidebarVisible, showDetails: $showDetails,
                    showDetailsSheet: $showDetailsSheet,
                    selectedGameId: $selectedGameId,
                    commonSelectedGameId: $commonSelectedGameId,
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
                .padding(.top, 20)
                .padding(.bottom, 20)
            } else if layoutStyle == "Grid" {
                GamesGridView(
                    games: $games,
                    selectedPlatform: $selectedPlatform,
                    searchText: $searchText,
                    selectedButton: $selectedButton,
                    isSidebarVisible: $isSidebarVisible, showDetails: $showDetails,
                    showDetailsSheet: $showDetailsSheet,
                    selectedGameId: $selectedGameId,
                    commonSelectedGameId: $commonSelectedGameId,
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
                    .padding(.top, 20)
                    .padding(.bottom, 20)
            } else {
                HomeView(
                    games: $games,
                    selectedGameId: $selectedGameId,
                    selectedPlatform: $selectedPlatform,
                    searchText: $searchText,
                    selectedButton: $selectedButton,
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
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
        }
    }
    
    private func verifyGamesFolder() {
        FileManager.default.verifyGamesFolder()
    }

    private func loadGames() {
        games = FileManager.default.scanGamesFolder()
    }

    private func loadSettings() {
        homeViewVisibility = UserDefaults.standard.dictionary(forKey: "homeViewVisibility") as? [String: Bool] ?? [:]
        gameViewOrder = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [:]
    }
}
