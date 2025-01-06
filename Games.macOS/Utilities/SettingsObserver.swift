import SwiftUI
import Combine

class SettingsManager: ObservableObject {
    @Published var sidebarVisibility: [String: Bool]
    @Published var gameViewOrder: [String]

    init() {
        self.sidebarVisibility = UserDefaults.standard.dictionary(forKey: "sidebarVisibility") as? [String: Bool] ?? [
            "Recently Played": true,
            "Favorites": true,
            "Newly Added": true,
            "Random": true,
            "Multiplayer": true,
            "Online": true,
            "Downloads": true,
            "Broken": true,
            "Saves": true
        ]
        
        self.gameViewOrder = UserDefaults.standard.array(forKey: "gameViewOrder") as? [String] ?? [
            "Recently Played",
            "Favorites",
            "Newly Added",
            "Random",
            "Multiplayer",
            "Online",
            "Downloads",
            "Broken",
            "Saves"
        ]
    }

    func saveSettings() {
        UserDefaults.standard.set(sidebarVisibility, forKey: "sidebarVisibility")
        UserDefaults.standard.set(gameViewOrder, forKey: "gameViewOrder")
    }
}
