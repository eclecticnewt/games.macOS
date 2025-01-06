import Foundation

struct GameLauncher {
    static func launchGame(game: Game) {
        let process = Process()
        
        switch game.platform {
        case "Microsoft Xbox":
            let xemuPath = "/Applications/xemu.app/Contents/MacOS/xemu"
            process.executableURL = URL(fileURLWithPath: xemuPath)
            process.arguments = ["-dvd_path", game.filePath]
        case "Sony PlayStation 2":
            let aethersx2Path = "/Users/[name]/Library/Mobile Documents/com~apple~CloudDocs/Media/Games.macOS/Games.macOS/Platforms/AetherSX2/AetherSX2.app/Contents/MacOS/AetherSX2"
            process.executableURL = URL(fileURLWithPath: aethersx2Path)
            process.arguments = [game.filePath]
        case "Sega Dreamcast":
            launchRetroArch(withCore: "flycast_libretro.dylib", forGame: game)
            return
        case "Sega Genesis":
            launchRetroArch(withCore: "genesis_plus_gx_libretro.dylib", forGame: game)
            return
        case "Nintendo Game Boy", "Nintendo Game Boy Color":
            launchRetroArch(withCore: "gambatte_libretro.dylib", forGame: game)
            return
        case "Nintendo Game Boy Advance":
            launchRetroArch(withCore: "mgba_libretro.dylib", forGame: game)
            return
        case "Nintendo DS":
            launchRetroArch(withCore: "melonds_libretro.dylib", forGame: game)
            return
        case "Super Nintendo Entertainment System":
            launchRetroArch(withCore: "snes9x2010_libretro.dylib", forGame: game)
            return
        case "Nintendo 64":
            launchRetroArch(withCore: "mupen64plus_next_libretro.dylib", forGame: game)
            return
        case "Sony PlayStation Portable":
            launchRetroArch(withCore: "ppsspp_libretro.dylib", forGame: game)
            return
        case "Sony PlayStation":
            launchRetroArch(withCore: "swanstation_libretro.dylib", forGame: game)
            return
        case "Nintendo GameCube", "Nintendo Wii":
            let dolphinPath = "/Users/[name]/Library/Mobile Documents/com~apple~CloudDocs/Media/Games.macOS/Games.macOS/Platforms/Dolphin/Dolphin.app/Contents/MacOS/Dolphin"
            process.executableURL = URL(fileURLWithPath: dolphinPath)
            process.arguments = [game.filePath]
        default:
            return
        }
        
        do {
            try process.run()
            process.waitUntilExit()
            // Update the last played date after launching the game
            DatabaseManager.shared.updateLastPlayedDate(for: game)
        } catch {
            print("Failed to launch game: \(error)")
        }
    }
    
    private static func launchRetroArch(withCore core: String, forGame game: Game) {
        let retroArchPath = "/Users/[name]/Library/Mobile Documents/com~apple~CloudDocs/Media/Games.macOS/Games.macOS/Platforms/RetroArch/RetroArch.app/Contents/MacOS/RetroArch"
        let corePath = "/Users/[name]/Library/Mobile Documents/com~apple~CloudDocs/Media/Games.macOS/Games.macOS/Platforms/RetroArch/RetroArch/cores/\(core)"
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/zsh")
        process.arguments = ["-c", "\"\(retroArchPath)\" -f -L \"\(corePath)\" \"\(game.filePath)\""]
        
        do {
            try process.run()
            process.waitUntilExit()
            // Update the last played date after launching the game
            DatabaseManager.shared.updateLastPlayedDate(for: game)
        } catch {
            print("Failed to launch game: \(error)")
        }
    }
}
