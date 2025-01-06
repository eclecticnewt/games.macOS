import SwiftUI
import AppKit

struct AccountSettingsView: View {
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? "Username"
    @State private var bio: String = UserDefaults.standard.string(forKey: "bio") ?? "This is your bio."
    @State private var isEditingUsername = false
    @State private var isEditingBio = false
    @State private var profileImage: NSImage? = {
        if let data = UserDefaults.standard.data(forKey: "profileImage"),
           let image = NSImage(data: data) {
            return image
        }
        return nil
    }()
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .top, spacing: 20) {
                            ZStack {
                                if let image = profileImage {
                                    Image(nsImage: image)
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            showImagePicker()
                                        }
                                } else {
                                    CircularButton(
                                        label: "Profile",
                                        systemImage: "person",
                                        action: {
                                            showImagePicker()
                                        }
                                    )
                                }
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    if isEditingUsername {
                                        TextField("Username", text: $username)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .onSubmit {
                                                UserDefaults.standard.set(username, forKey: "username")
                                                isEditingUsername = false
                                            }
                                        Button(action: {
                                            isEditingUsername = false
                                            UserDefaults.standard.set(username, forKey: "username")
                                        }) {
                                            Image(systemName: "checkmark")
                                        }
                                        Button(action: {
                                            isEditingUsername = false
                                            username = UserDefaults.standard.string(forKey: "username") ?? "Your Username"
                                        }) {
                                            Image(systemName: "xmark")
                                        }
                                    } else {
                                        Text(username)
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Button(action: {
                                            isEditingUsername = true
                                        }) {
                                            Image(systemName: "pencil")
                                        }
                                    }
                                }
                                HStack {
                                    if isEditingBio {
                                        TextField("Bio", text: $bio, axis: .vertical)
                                            .lineLimit(3)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxHeight: 60)
                                            .onSubmit {
                                                UserDefaults.standard.set(bio, forKey: "bio")
                                                isEditingBio = false
                                            }
                                        Button(action: {
                                            isEditingBio = false
                                            UserDefaults.standard.set(bio, forKey: "bio")
                                        }) {
                                            Image(systemName: "checkmark")
                                        }
                                        Button(action: {
                                            isEditingBio = false
                                            bio = UserDefaults.standard.string(forKey: "bio") ?? "This is your bio. You can edit it by clicking the pencil icon."
                                        }) {
                                            Image(systemName: "xmark")
                                        }
                                    } else {
                                        Text(bio)
                                            .lineLimit(3)
                                            .font(.subheadline)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Button(action: {
                                            isEditingBio = true
                                        }) {
                                            Image(systemName: "pencil")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                    .padding(.leading, 40)
                    .padding(.top, 40)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Statistics")
                            .font(.headline)
                            .padding(.top, 20)
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("Most Played Game: Pokémon Snap")
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("Total Games Played: 150")
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("Total Time Played: 500 hours")
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text("Most Played Platform: Nintendo 64")
                            .foregroundColor(isDarkMode ? .white : .black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                    .padding(20)
                }
                .frame(width: geometry.size.width)
            }
        }
        .navigationTitle("Account Settings")
//        AvatarSettingsView()
    }

    private func showImagePicker() {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Choose Profile Picture"
        openPanel.allowedFileTypes = ["png", "jpg", "jpeg"]
        openPanel.begin { response in
            if response == .OK {
                if let url = openPanel.url, let image = NSImage(contentsOf: url) {
                    profileImage = image
                    if let imageData = image.tiffRepresentation {
                        UserDefaults.standard.set(imageData, forKey: "profileImage")
                    }
                }
            }
        }
    }
}

struct CircularButton: View {
    var label: String
    var systemImage: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .strokeBorder(Color(red: 0.2, green: 0.4, blue: 0.9), lineWidth: 4)
                .background(Circle().fill(Color.clear))
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: systemImage)
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.9))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}
