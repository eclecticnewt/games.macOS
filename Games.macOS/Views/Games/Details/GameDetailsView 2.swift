import SwiftUI

struct GameDetailsView: View {
    @State var game: Game
    @State private var isFavorited: Bool
    @State private var isBroken: Bool
    @State private var detailedGame: Game?
    @State private var contentHeight: CGFloat = 0

    init(game: Game) {
        self.game = game
        _isFavorited = State(initialValue: game.favorited)
        _isBroken = State(initialValue: game.broken)
        _detailedGame = State(initialValue: DatabaseManager.shared.fetchGameByName(game.name))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)

                if let detailedGame = detailedGame {
                    if detailedGame.description != "No description" {
                        ScrollView {
                            Text(detailedGame.description)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.primary)
                        }
                        .frame(maxHeight: 200)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.bottom, 5)
                    }

                    HStack(alignment: .top, spacing: 40) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Platform:").bold()
                                Text(game.platform)
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Release Date:").bold()
                                Text(formatDate(detailedGame.releaseDate))
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Genres:").bold()
                                Text(detailedGame.genres)
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Developers:").bold()
                                Text(detailedGame.developers)
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Publishers:").bold()
                                Text(detailedGame.publishers)
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("ESRB Rating:").bold()
                                Text(detailedGame.esrbRating)
                            }
                            .padding(.bottom, 5)
                        }

                        Spacer()

                        VStack(alignment: .leading) {
                            HStack {
                                Text("Last Played Date:").bold()
                                Text(formatDate(detailedGame.lastPlayedDate))
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Favorited:").bold()
                                Toggle("", isOn: $isFavorited)
                                    .labelsHidden()
                            }
                            .padding(.bottom, 5)
                            .onChange(of: isFavorited) { newValue in
                                game.favorited = newValue
                                DatabaseManager.shared.updateGame(game)
                            }

                            HStack {
                                Text("Multiplayer:").bold()
                                Text(detailedGame.multiplayer ? "Yes" : "No")
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Online:").bold()
                                Text(detailedGame.online ? "Yes" : "No")
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Downloaded:").bold()
                                Text(detailedGame.downloaded ? "Yes" : "No")
                            }
                            .padding(.bottom, 5)

                            HStack {
                                Text("Broken:").bold()
                                Toggle("", isOn: $isBroken)
                                    .labelsHidden()
                            }
                            .padding(.bottom, 5)
                            .onChange(of: isBroken) { newValue in
                                game.broken = newValue
                                DatabaseManager.shared.updateGame(game)
                            }

                            HStack {
                                Text("Achievements:").bold()
                                Text(detailedGame.achievements)
                            }
                            .padding(.bottom, 5)
                        }
                    }
                } else {
                    Text("No additional details found.")
                        .padding(.bottom, 5)
                }

                Spacer()
            }
            .padding()
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            self.contentHeight = proxy.size.height
                        }
                }
            )
        }
        .frame(maxWidth: 750, maxHeight: min(contentHeight, 500))
    }

    private func formatDate(_ date: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        if let date = dateFormatter.date(from: date) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .long
            return outputFormatter.string(from: date)
        }
        return date.isEmpty ? "Never Played" : date
    }
}
