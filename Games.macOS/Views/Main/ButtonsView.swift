import SwiftUI

struct ButtonsView: View {
    @Binding var isSidebarVisible: Bool
    @Binding var searchText: String
    @Binding var selectedButton: String?
    @Binding var selectedGameId: Int?
    @Binding var showDetails: Bool
    @Binding var showDetailsSheet: Bool
    var games: [Game]

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("buttonIconStyle") private var buttonIconStyle: String = "Letters" // Read button icon style

    var body: some View {
        HStack {
            // Sidebar Button
            Button(action: {
                self.isSidebarVisible.toggle()
            }) {
                HStack(spacing: 5) {
                    iconForStyle("Sidebar")
                        .foregroundColor(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
                        .font(.title2)
                    Text("Sidebar")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.system(size: 12))
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.clear)
                .cornerRadius(4)
            }
            .buttonStyle(PlainButtonStyle())

            // Details Button
            Button(action: {
                if selectedGameId != nil {
                    showDetailsSheet = true
                }
            }) {
                HStack(spacing: 5) {
                    iconForStyle("Details")
                        .foregroundColor(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
                        .font(.title2)
                    Text("Details")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.system(size: 12))
                }
                .padding(10)
                .background(Color.clear)
                .cornerRadius(4)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(selectedGameId == nil)

            // Launch Button
            if let selectedGameId = selectedGameId, let selectedGame = games.first(where: { $0.id == selectedGameId }) {
                Button(action: {
                    GameLauncher.launchGame(game: selectedGame)
                }) {
                    HStack(spacing: 5) {
                        iconForStyle("Launch")
                            .foregroundColor(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
                            .font(.title2)
                        Text("Launch")
                            .foregroundColor(isDarkMode ? .white : .black)
                            .font(.system(size: 12))
                    }
                    .padding(10)
                    .background(Color.clear)
                    .cornerRadius(4)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Button(action: {}) {
                    HStack(spacing: 5) {
                        iconForStyle("Launch")
                            .foregroundColor(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
                            .font(.title2)
                        Text("Launch")
                            .foregroundColor(isDarkMode ? .white : .black)
                            .font(.system(size: 12))
                    }
                    .padding(10)
                    .background(Color.clear)
                    .cornerRadius(4)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(true)
            }
        }
        .padding(.horizontal)
    }

    /// Generates the appropriate icon based on buttonIconStyle
    private func iconForStyle(_ button: String) -> Image {
        switch buttonIconStyle {
        case "Letters":
            switch button {
            case "Sidebar": return Image(systemName: "y.circle")
            case "Details": return Image(systemName: "x.circle")
            case "Launch": return Image(systemName: "a.circle")
            default: return Image(systemName: "questionmark.circle")
            }
        case "Symbols":
            switch button {
            case "Sidebar": return Image(systemName: "triangle.circle")
            case "Details": return Image(systemName: "square.circle")
            case "Launch": return Image(systemName: "circle.circle")
            default: return Image(systemName: "questionmark.circle")
            }
        case "None":
            return Image(systemName: "circle.dashed")
        default:
            return Image(systemName: "questionmark.circle")
        }
    }
}
