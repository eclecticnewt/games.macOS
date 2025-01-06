import SwiftUI

struct SidebarButtonsView: View {
    @Binding var selectedButton: String?
    @Binding var selectedGameId: Int?
    @FocusState.Binding var isSearchBarFocused: Bool
    @Binding var searchText: String
    @Binding var selectedPlatform: String?
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Binding var sidebarVisibility: [String: Bool]
    @Binding var gameViewOrder: [String: Int]

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            ForEach(sortedSidebarButtons(), id: \.self) { label in
                if sidebarVisibility[label] ?? true { // Check visibility setting
                    SidebarButton(
                        label: label,
                        systemImage: systemImage(for: label),
                        selectedButton: $selectedButton,
                        selectedGameId: $selectedGameId,
                        isSearchBarFocused: $isSearchBarFocused,
                        searchText: $searchText,
                        selectedPlatform: $selectedPlatform,
                        isDarkMode: isDarkMode
                    )
                }
            }
            Spacer()
            SidebarButton(
                label: "Power",
                systemImage: systemImage(for: "Power"),
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                isDarkMode: isDarkMode
            )
        }
    }

    private func sortedSidebarButtons() -> [String] {
        return gameViewOrder.sorted(by: { $0.value < $1.value }).map { $0.key }
    }

    private func systemImage(for label: String) -> String {
        switch label {
        case "Recently Played":
            return "timer"
        case "Favorites":
            return "heart"
        case "Newly Added":
            return "burst"
        case "Random":
            return "shuffle"
        case "Multiplayer":
            return "person.2"
        case "Online":
            return "network"
        case "Downloads":
            return "square.and.arrow.down"
        case "Broken":
            return "exclamationmark.triangle"
        case "Saves":
            return "folder"
        default:
            return "power"
        }
    }
    
    struct SidebarButton: View {
        var label: String
        var systemImage: String
        @Binding var selectedButton: String?
        @Binding var selectedGameId: Int?
        @FocusState.Binding var isSearchBarFocused: Bool
        @Binding var searchText: String
        @Binding var selectedPlatform: String?
        var isDarkMode: Bool

        var body: some View {
            HStack(spacing: 5) {
                Image(systemName: systemImage)
                    .frame(width: 28, alignment: .center)
                    .foregroundColor(selectedButton == label ? .white : (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9)))
                Text(label)
                    .foregroundColor(selectedButton == label || isDarkMode ? .white : .black)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(selectedButton == label ? (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9)) : Color.clear)
            .cornerRadius(4)
            .onTapGesture {
                isSearchBarFocused = false
                selectedButton = label
                selectedGameId = nil
                searchText = ""
                selectedPlatform = nil
            }
        }
    }
}
