import SwiftUI

struct PlatformsView: View {
    @Binding var selectedGameId: Int?
    @Binding var selectedPlatform: String?
    @Binding var searchText: String
    @FocusState.Binding var isSearchBarFocused: Bool
    @Binding var selectedButton: String?
    @State private var platforms: [Platform] = [
        Platform(name: "Arcade", imageName: "Arcade"),
        Platform(name: "Atari 2600", imageName: "Atari 2600"),
        Platform(name: "Atari 5200", imageName: "Atari 5200"),
        Platform(name: "Atari 7800", imageName: "Atari 7800"),
        Platform(name: "Nintendo Game Boy", imageName: "Nintendo Game Boy"),
        Platform(name: "Nintendo Game Boy Color", imageName: "Nintendo Game Boy Color"),
        Platform(name: "Nintendo Game Boy Advance", imageName: "Nintendo Game Boy Advance"),
        Platform(name: "Nintendo DS", imageName: "Nintendo DS"),
        Platform(name: "Nintendo 3DS", imageName: "Nintendo 3DS"),
        Platform(name: "Nintendo Entertainment System", imageName: "Nintendo Entertainment System"),
        Platform(name: "Super Nintendo Entertainment System", imageName: "Super Nintendo Entertainment System"),
        Platform(name: "Nintendo 64", imageName: "Nintendo 64"),
        Platform(name: "Nintendo GameCube", imageName: "Nintendo GameCube"),
        Platform(name: "Nintendo Wii", imageName: "Nintendo Wii"),
        Platform(name: "Sega Genesis", imageName: "Sega Genesis"),
        Platform(name: "Sega Dreamcast", imageName: "Sega Dreamcast"),
        Platform(name: "Sony PlayStation Portable", imageName: "Sony PlayStation Portable"),
        Platform(name: "Sony PlayStation", imageName: "Sony PlayStation"),
        Platform(name: "Sony PlayStation 2", imageName: "Sony PlayStation 2"),
        Platform(name: "Sony PlayStation 3", imageName: "Sony PlayStation 3"),
        Platform(name: "Microsoft Xbox", imageName: "Microsoft Xbox"),
        Platform(name: "Microsoft Xbox 360", imageName: "Microsoft Xbox 360"),
        Platform(name: "Flash", imageName: "Flash"),
        Platform(name: "Windows", imageName: "Windows")
    ]
    @State private var tileWidth: CGFloat = 175
    @State private var spacing: CGFloat = 15
    @State private var geometryWidth: CGFloat = 0

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Platforms")
                .font(.title)
                .bold()
                .foregroundColor(isDarkMode ? .white : .black) // Adjusted for dark mode
                .padding(.leading, 20)
                .padding(.top, 20)

            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: self.spacing) {
                        ForEach(platforms) { platform in
                            PlatformTileView(platform: platform, isSelected: selectedPlatform == platform.name, isDarkMode: isDarkMode)
                                .onTapGesture {
                                    selectedPlatform = platform.name
                                    isSearchBarFocused = false
                                    selectedButton = nil
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
                .onChange(of: geometry.size.width) { newWidth in
                    self.geometryWidth = newWidth
                    self.calculateTileSize(with: newWidth)
                }
                .onAppear {
                    self.geometryWidth = geometry.size.width
                    self.calculateTileSize(with: geometry.size.width)
                    searchText = ""
                }
            }
            .frame(height: tileWidth + 20)
        }
    }

    private func calculateTileSize(with width: CGFloat) {
        let availableWidth = width - 40
        let minSpacing: CGFloat = 15
        let idealTileWidth: CGFloat = 175

        let numberOfTiles = floor(availableWidth / (idealTileWidth + minSpacing))

        let totalSpacing = minSpacing * (numberOfTiles - 1)
        let calculatedTileWidth = (availableWidth - totalSpacing) / numberOfTiles

        self.tileWidth = min(calculatedTileWidth, idealTileWidth)
        self.spacing = (availableWidth - (self.tileWidth * numberOfTiles)) / (numberOfTiles - 1)
    }
}

struct Platform: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct PlatformTileView: View {
    let platform: Platform
    let isSelected: Bool
    let isDarkMode: Bool

    var body: some View {
        ZStack {
            (isDarkMode ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                .frame(width: 175, height: 175)
                .cornerRadius(8)

            Image(platform.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .frame(maxWidth: 175, maxHeight: 175)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color.blue) : Color.clear, lineWidth: isSelected ? 3 : 0)
                )
        }
    }
}
