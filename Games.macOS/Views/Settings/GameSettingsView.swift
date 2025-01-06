import SwiftUI

struct GamesSettingsView: View {
    @State private var gamesDirectory: String = UserDefaults.standard.string(forKey: "gamesDirectory") ?? ""
    @State private var boxArtDirectory: String = UserDefaults.standard.string(forKey: "boxArtDirectory") ?? ""
    @State private var startScreenDirectory: String = UserDefaults.standard.string(forKey: "startScreenDirectory") ?? ""
    @State private var gameplayDirectory: String = UserDefaults.standard.string(forKey: "startScreenDirectory") ?? ""
    @State private var trailersDirectory: String = UserDefaults.standard.string(forKey: "startScreenDirectory") ?? ""
    @State private var localSavesDirectory: String = UserDefaults.standard.string(forKey: "localSavesDirectory") ?? ""
    @State private var cloudSavesDirectory: String = UserDefaults.standard.string(forKey: "cloudSavesDirectory") ?? ""
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        Section(header: Text("Games").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Games Directory:")
                                        .frame(width: 200, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $gamesDirectory)
                                        .frame(maxWidth: 400)
                                        .onChange(of: gamesDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "gamesDirectory")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)

                        Section(header: Text("Images").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Box Art Directory:")
                                        .frame(width: 200, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $boxArtDirectory)
                                        .frame(maxWidth: 400)
                                        .onChange(of: boxArtDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "boxArtDirectory")
                                        })
                                }
                                HStack {
                                    Text("Start Screen Directory:")
                                        .frame(width: 200, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $startScreenDirectory)
                                        .frame(maxWidth: 400)
                                        .onChange(of: startScreenDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "startScreenDirectory")
                                        })
                                }
                                
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Section(header: Text("Videos").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Gameplay Directory:")
                                        .frame(width: 200, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $gameplayDirectory)
                                        .frame(maxWidth: 400)
                                        .onChange(of: gameplayDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "gameplayDirectory")
                                        })
                                }
                                HStack {
                                    Text("Trailers Directory:")
                                        .frame(width: 200, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $trailersDirectory)
                                        .frame(maxWidth: 400)
                                        .onChange(of: trailersDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "trailersDirectory")
                                        })
                                }
                                
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                    .padding(20)

                    VStack(alignment: .leading) {
                        Section(header: Text("Saves").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Local Directory:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $localSavesDirectory)
                                        .frame(maxWidth: 600)
                                        .onChange(of: localSavesDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "localSavesDirectory")
                                        })
                                }
                                HStack {
                                    Text("Cloud Directory:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $cloudSavesDirectory)
                                        .frame(maxWidth: 600)
                                        .onChange(of: cloudSavesDirectory, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "cloudSavesDirectory")
                                        })
                                }
                                Button(action: {
                                    syncSaves()
                                }) {
                                    Text("Sync Saves")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .buttonStyle(DefaultButtonStyle())
                                .padding(.top, 10)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                    .padding(20)
                }
                .frame(width: geometry.size.width)
            }
        }
        .navigationTitle("Games Settings")
    }

    private func syncSaves() {
        // Implement sync saves action
        print("Syncing saves...")
    }
}

struct GamesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GamesSettingsView()
    }
}
