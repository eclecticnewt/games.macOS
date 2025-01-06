import SwiftUI

struct KeyboardCarouselView: View {
    @Binding var searchText: String
    @AppStorage("isOnScreenKeyboard") private var isOnScreenKeyboard: Bool = false

//    @Binding var isOnScreenKeyboard: Bool
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State private var isUppercase: Bool = true
    @State private var showSpecialCharacters: Bool = false

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                ForEach(horizontalKeys, id: \.self) { row in
                    keyRow(row: row, width: geometry.size.width)
                }

                HStack(spacing: 10) {
                    shiftButton()
                    specialCharactersButton()
                    spaceButton()
                    deleteButton()
                }
            }
            .padding(20)
            .background(isDarkMode ? Color.black : Color(white: 0.95))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the keyboard spans the available space
        }
    }

    private var horizontalKeys: [[String]] {
        if showSpecialCharacters {
            return [["!", "@", "#", "$", "%", "^", "&", "*", "(", ")"], ["-", "_", "=", "+", "[", "]", "{", "}", ";", ":"], [",", ".", "?", "/", "|", "~", "`", "\"", "'"]]
        } else {
            return [["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"], ["A", "S", "D", "F", "G", "H", "J", "K", "L"], ["Z", "X", "C", "V", "B", "N", "M"]]
        }
    }

    @ViewBuilder
    private func keyRow(row: [String], width: CGFloat) -> some View {
        HStack(spacing: 10) {
            ForEach(row, id: \.self) { key in
                Button(action: {
                    self.searchText.append(isUppercase ? key.uppercased() : key.lowercased())
                    self.isOnScreenKeyboard = true
                }) {
                    Text(isUppercase ? key.uppercased() : key.lowercased())
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(isDarkMode ? .white : .black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .cornerRadius(8)
                }
                .background(isDarkMode ? Color.gray : Color(white: 0.9))
            }
        }
    }

    // Utility buttons
    private func shiftButton() -> some View {
        Button(action: { isUppercase.toggle() }) {
            Image(systemName: isUppercase ? "shift.fill" : "shift")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.gray : Color(white: 0.9))
    }

    private func specialCharactersButton() -> some View {
        Button(action: { showSpecialCharacters.toggle() }) {
            Text(showSpecialCharacters ? (isUppercase ? "ABC" : "abc") : "#+=")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.gray : Color(white: 0.9))
    }
    
    private func spaceButton() -> some View {
        Button(action: { self.searchText.append(" ") }) {
            Text("Space")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.gray : Color(white: 0.9))
    }

    private func deleteButton() -> some View {
        Button(action: {
            if !self.searchText.isEmpty {
                self.searchText.removeLast()
            }
            self.isOnScreenKeyboard = true
        }) {
            Image(systemName: "delete.left.fill")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(isDarkMode ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(8)
        }
        .background(isDarkMode ? Color.red : Color(white: 0.9))
    }
}
