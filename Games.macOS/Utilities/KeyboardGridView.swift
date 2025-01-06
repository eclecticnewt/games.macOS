import SwiftUI

struct KeyboardGridView: View {
    @Binding var searchText: String
    @AppStorage("isOnScreenKeyboard") private var isOnScreenKeyboard: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State private var isUppercase: Bool = true
    @State private var showSpecialCharacters: Bool = false

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                // Key rows, adapted to grid layout (7 rows, 4 keys each)
                ForEach(gridKeys, id: \.self) { row in
                    keyRow(row: row, width: geometry.size.width)
                }

                // Bottom row for space and delete
                HStack(spacing: 10) {
                    spaceButton()
                    deleteButton()
                }
            }
            .padding(20)
            .background(isDarkMode ? Color.black.opacity(0.25) : Color(white: 0.95))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Take up all available space
        }
    }

    // Key layout for the grid (7 rows with 4 keys each, plus Shift and #+=)
    private var gridKeys: [[String]] {
        if showSpecialCharacters {
            return [["!", "@", "#", "$"], ["%", "^", "&", "*"], ["(", ")", "-", "="], ["_", "+", "[", "]"], ["{", "}", ";", ":"], [",", ".", "?", "/"], ["'", "\"", "⇧", "AB"]]
        } else {
            return [["Q", "W", "E", "R"], ["T", "Y", "U", "I"], ["O", "P", "A", "S"], ["D", "F", "G", "H"], ["J", "K", "L", "Z"], ["X", "C", "V", "B"], ["N", "M", "⇧", "!@"]]
        }
    }

    // Function to generate a row of keys
@ViewBuilder
private func keyRow(row: [String], width: CGFloat) -> some View {
    HStack(spacing: 10) {
        ForEach(row, id: \.self) { key in
            Button(action: {
                handleKeyPress(key: key) // Handles key press for letters, shift, and special characters
                self.isOnScreenKeyboard = true
            }) {
                if key == "⇧" {
                    Image(systemName: isUppercase ? "shift.fill" : "shift")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(isDarkMode ? .white : .black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .cornerRadius(8)
                } else {
                    Text(isUppercase ? key.uppercased() : key.lowercased())
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(isDarkMode ? .white : .black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .cornerRadius(8)
                }
            }
            .background(isDarkMode ? Color.gray.opacity(0.1) : Color(white: 0.9))
        }
    }
    .frame(maxHeight: .infinity) // This ensures the row takes up all available vertical space
}

    // Handles key press actions for letters, "Shift", and "!@" or "AB"
    private func handleKeyPress(key: String) {
        switch key {
        case "⇧":
            isUppercase.toggle()
        case "!@":
            showSpecialCharacters = true
        case "AB":
            showSpecialCharacters = false
        default:
            self.searchText.append(isUppercase ? key.uppercased() : key.lowercased())
        }
    }

    // Shift button with filled arrow when active
    private func shiftButton() -> some View {
        Button(action: { isUppercase.toggle() }) {
            Image(systemName: isUppercase ? "shift.fill" : "shift")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.gray.opacity(0.1) : Color(white: 0.9))
    }

    // Special characters toggle button
    private func specialCharactersButton() -> some View {
        Button(action: { showSpecialCharacters.toggle() }) {
            Text(showSpecialCharacters ? (isUppercase ? "ABC" : "abc") : "#+=")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.gray.opacity(0.1) : Color(white: 0.9))
    }

    // Space bar button
    private func spaceButton() -> some View {
        Button(action: { self.searchText.append(" ") }) {
            Text("Space")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.gray.opacity(0.1) : Color(white: 0.9))
    }

    // Delete button
    private func deleteButton() -> some View {
        Button(action: { if !self.searchText.isEmpty { self.searchText.removeLast() } }) {
            Image(systemName: "delete.left.fill")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.red : Color.red.opacity(0.5))
    }
}
