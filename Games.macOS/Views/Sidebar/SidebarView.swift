import SwiftUI

struct SidebarView: View {
    @Binding var searchText: String
    @FocusState.Binding var isSearchBarFocused: Bool
    @Binding var selectedButton: String?
    @Binding var selectedPlatform: String?
    @Binding var selectedGameId: Int?
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    @State private var sidebarVisibility: [String: Bool] = UserDefaults.standard.dictionary(forKey: "sidebarVisibility") as? [String: Bool] ?? [:]
    @State private var gameViewOrder: [String: Int] = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [:]

    var body: some View {
        VStack(alignment: .leading) {
            SidebarIconButtonsView(
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform
            )
            .padding(.top, 20)
            SearchBarView(
                searchText: $searchText,
                isSearchBarFocused: $isSearchBarFocused,
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                selectedPlatform: $selectedPlatform
            )
            .padding(.top, 4)
            SidebarButtonsView(
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                sidebarVisibility: $sidebarVisibility,
                gameViewOrder: $gameViewOrder
            )
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            Spacer()
        }
        .frame(width: 250)
        .background(Color.gray.opacity(0.1))
        .overlay(
            Rectangle()
                .frame(width: 1)
                .foregroundColor(isDarkMode ? .black : Color.gray.opacity(0.3))
                .edgesIgnoringSafeArea(.vertical),
            alignment: .trailing
        )
        .onAppear {
            loadSettings()
        }
        .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
            loadSettings()
        }
    }

    private func loadSettings() {
        sidebarVisibility = UserDefaults.standard.dictionary(forKey: "sidebarVisibility") as? [String: Bool] ?? [:]
        gameViewOrder = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [:]
    }
}
