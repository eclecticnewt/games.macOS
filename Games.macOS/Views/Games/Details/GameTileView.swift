import SwiftUI

struct GameTileView: View {
    let game: Game
    let isSelected: Bool
    let onTap: () -> Void

    // Expecting the parent view to pass in the dark mode setting
    let isDarkMode: Bool

    @AppStorage("showGameNameUnderTile") private var showGameNameUnderTile: Bool = true // Reads the setting

    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                if let image = NSImage(named: game.imageName) {
                    ZStack {
                        Image(nsImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                        if isSelected {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color.blue, lineWidth: 3)
                                .frame(width: 150, height: 150)
                        }
                    }
                } else {
                    ZStack {
                        (isDarkMode ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                            .frame(width: 150, height: 150)
                            .cornerRadius(8)
                        Text(game.name)
                            .font(.headline)
                            .foregroundColor(isDarkMode ? .white : .black)
                            .padding(10)
                            .frame(width: 150, height: 150, alignment: .center)
                            .cornerRadius(8)
                        if isSelected {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color.blue, lineWidth: 3)
                                .frame(width: 150, height: 150)
                        }
                    }
                }
            }
            .frame(width: 150, height: 150)
            .onTapGesture {
                onTap()
            }

            // Show game name under tile if the setting is enabled
            if showGameNameUnderTile {
                Text(game.name)
                    .font(.subheadline)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 150)
            }
        }
    }
}
