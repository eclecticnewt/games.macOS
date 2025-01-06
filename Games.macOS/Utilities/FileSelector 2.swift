import SwiftUI

struct FileSelectorView: View {
    @Binding var filePath: String
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        HStack {
            // Display the last file component with color styling
            Text(getLastFileComponent(from: filePath))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(isDarkMode ? .white : .black)

            // Select button with consistent styling
            Button(action: {
                selectFile()
            }) {
                Text("Select")
                    .foregroundColor(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
            }
        }
    }

    private func selectFile() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.allowedFileTypes = ["app", "exe"] // Adjust file types as needed
        panel.begin { response in
            if response == .OK, let url = panel.url {
                filePath = url.path
            }
        }
    }

    // Function to get only the last file component (file name)
    private func getLastFileComponent(from path: String) -> String {
        return URL(fileURLWithPath: path).lastPathComponent
    }
}
