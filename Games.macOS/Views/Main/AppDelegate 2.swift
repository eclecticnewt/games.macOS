import Cocoa
import AppIntents

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppIntentsHandler.shared.setup()
    }
}

class AppIntentsHandler {
    static let shared = AppIntentsHandler()

    func setup() {
        // macOS does not have INPreferences, so we skip this step.
        // Ensure your intent definitions are properly registered.
        // You might need to handle other setup tasks specific to your app.
    }
}
