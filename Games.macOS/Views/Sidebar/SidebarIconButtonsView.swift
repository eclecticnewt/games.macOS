import SwiftUI

struct SidebarIconButtonsView: View {
    @Binding var selectedButton: String?
    @Binding var selectedGameId: Int?
    @FocusState.Binding var isSearchBarFocused: Bool
    @Binding var searchText: String
    @Binding var selectedPlatform: String?
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        HStack(spacing: 5) {
            CircularButton(
                label: "Profile",
                systemImage: "person",
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                isDarkMode: isDarkMode
            )
            Spacer()
            CircularButton(
                label: "Home",
                systemImage: "house",
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                isDarkMode: isDarkMode
            )
            Spacer()
            CircularButton(
                label: "Achievements",
                systemImage: "trophy",
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                isDarkMode: isDarkMode
            )
            Spacer()
            CircularButton(
                label: "Media",
                systemImage: "camera",
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                isDarkMode: isDarkMode
            )
            Spacer()
            CircularButton(
                label: "Settings",
                systemImage: "gearshape",
                selectedButton: $selectedButton,
                selectedGameId: $selectedGameId,
                isSearchBarFocused: $isSearchBarFocused,
                searchText: $searchText,
                selectedPlatform: $selectedPlatform,
                isDarkMode: isDarkMode
            )
        }
        .padding(.horizontal, 20)
    }

    struct CircularButton: View {
        var label: String
        var systemImage: String
        @Binding var selectedButton: String?
        @Binding var selectedGameId: Int?
        @FocusState.Binding var isSearchBarFocused: Bool
        @Binding var searchText: String
        @Binding var selectedPlatform: String?
        var isDarkMode: Bool

        var body: some View {
            Button(action: {
                isSearchBarFocused = false
                selectedButton = label
                selectedGameId = nil
                searchText = ""
                selectedPlatform = nil
            }) {
                ZStack {
                    Circle()
                        .fill(selectedButton == label
                              ? (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
                              : (isDarkMode ? Color.gray.opacity(0.3) : Color.white))
                        .frame(width: 24, height: 24)
                        .overlay(
                            Circle().stroke(selectedButton == label
                                            ? (isDarkMode ? Color.white : Color(red: 0.5, green: 0.7, blue: 1.0))
                                            : (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9)), lineWidth: 1.5)
                        )
                    Image(systemName: systemImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .foregroundColor(selectedButton == label
                                         ? (isDarkMode ? Color.white : Color(red: 0.5, green: 0.7, blue: 1.0))
                                         : (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9)))
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
