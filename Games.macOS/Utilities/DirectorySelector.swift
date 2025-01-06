import SwiftUI

struct DirectorySelectorView: View {
    @Binding var directoryPath: String
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        HStack {
            Text(getLastDirectoryComponent(from: directoryPath))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(isDarkMode ? .white : .black)

            Button(action: {
                selectDirectory()
            }) {
                Text("Select")
                    .foregroundColor(isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9))
//                    .foregroundColor(isDarkMode ? .blue : .black)
            }
        }
    }

    private func selectDirectory() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.begin { response in
            if response == .OK, let url = panel.url {
                directoryPath = url.path
            }
        }
    }

    private func getLastDirectoryComponent(from path: String) -> String {
        return URL(fileURLWithPath: path).lastPathComponent
    }
}
