import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @FocusState.Binding var isSearchBarFocused: Bool
    @Binding var selectedButton: String?
    @Binding var selectedGameId: Int?
    @Binding var selectedPlatform: String?

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(isDarkMode ? Color.white.opacity(0.2) : Color.gray.opacity(0.2))
                .frame(height: 28)
                .offset(y: 5)
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isSearchBarFocused ?
                    (isDarkMode ? Color(red: 0.5, green: 0.7, blue: 1.0) : Color(red: 0.2, green: 0.4, blue: 0.9)) :
                    Color.clear,
                    lineWidth: 4
                )
                .frame(height: 28)
                .offset(y: 5)
            HStack(spacing: 2) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(isDarkMode ? .white : .gray)
                    .padding(.leading, 4)
                    .padding(.top, 9)
                if searchText.isEmpty {
                    Text("Search")
                        .foregroundColor(isDarkMode ? Color(red: 0.85, green: 0.85, blue: 0.85) : .gray)
                        .padding(.vertical, 5)
                        .padding(.leading, 2)
                        .padding(.top, 9)
                }
                TextField("", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .focused($isSearchBarFocused)
                    .padding(.vertical, 5)
                    .padding(.leading, 2)
                    .padding(.top, 9)
                    .foregroundColor(isDarkMode ? .white : .black) // Ensure the text color is also white in dark mode
                    .onTapGesture {
                        isSearchBarFocused = true
                    }
            }
            .padding(.horizontal, 8)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .onChange(of: isSearchBarFocused) { focused in
            if focused {
                selectedButton = "Search"
                selectedPlatform = nil
                selectedGameId = nil
            }
        }
    }
}
