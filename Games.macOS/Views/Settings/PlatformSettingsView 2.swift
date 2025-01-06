import SwiftUI

struct PlatformsSettingsView: View {
    @State private var retroArchPath: String = UserDefaults.standard.string(forKey: "retroArchPath") ?? ""
    @State private var retroArchCoresPath: String = UserDefaults.standard.string(forKey: "retroArchCoresPath") ?? ""
    @State private var dolphinPath: String = UserDefaults.standard.string(forKey: "dolphinPath") ?? ""
    @State private var aetherSX2Path: String = UserDefaults.standard.string(forKey: "aetherSX2Path") ?? ""
    @State private var xemuPath: String = UserDefaults.standard.string(forKey: "xemuPath") ?? ""
    @State private var rpcs3Path: String = UserDefaults.standard.string(forKey: "rpcs3Path") ?? ""
    @State private var xeniaPath: String = UserDefaults.standard.string(forKey: "xeniaPath") ?? ""
    @State private var logosDirectory: String = UserDefaults.standard.string(forKey: "boxArtDirectory") ?? ""
    @State private var splashScreensDirectory: String = UserDefaults.standard.string(forKey: "boxArtDirectory") ?? ""
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State private var selectedPlatforms: [String: Bool] = {
        if let savedPlatforms = UserDefaults.standard.dictionary(forKey: "selectedPlatforms") as? [String: Bool] {
            return savedPlatforms
        }
        return [
            "Arcade": false,
            "Atari 2600": false,
            "Atari 5200": false,
            "Atari 7800": false,
            "Nintendo Game Boy": false,
            "Nintendo Game Boy Color": false,
            "Nintendo Game Boy Advance": false,
            "Nintendo DS": false,
            "Nintendo 3DS": false,
            "Nintendo Entertainment System": false,
            "Super Nintendo Entertainment System": false,
            "Nintendo 64": false,
            "Nintendo GameCube": false,
            "Nintendo Wii": false,
            "Sega Genesis": false,
            "Sega Dreamcast": false,
            "Sony PlayStation Portable": false,
            "Sony PlayStation": false,
            "Sony PlayStation 2": false,
            "Sony PlayStation 3": false,
            "Microsoft Xbox": false,
            "Microsoft Xbox 360": false,
            "Flash": false,
            "Windows": false
        ]
    }()

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        Section(header: Text("RetroArch").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Emulator Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    FileSelectorView(filePath: $retroArchPath)
                                        .frame(maxWidth: 600)
                                        .onChange(of: retroArchPath, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "retroArchPath")
                                        })
                                }
                                HStack {
                                    Text("Cores Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    DirectorySelectorView(directoryPath: $retroArchCoresPath)
                                        .frame(maxWidth: 600)
                                        .onChange(of: retroArchCoresPath, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "retroArchCoresPath")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Section(header: Text("Dolphin").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Emulator Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    FileSelectorView(filePath: $dolphinPath)
                                        .frame(maxWidth: 600)
                                        .onChange(of: dolphinPath, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "dolphinPath")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Section(header: Text("AetherSX2").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Emulator Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    FileSelectorView(filePath: $aetherSX2Path)
                                        .frame(maxWidth: 600)
                                        .onChange(of: aetherSX2Path, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "aetherSX2Path")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Section(header: Text("Xemu").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Emulator Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    FileSelectorView(filePath: $xemuPath)
                                        .frame(maxWidth: 600)
                                        .onChange(of: xemuPath, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "xemuPath")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Section(header: Text("RPCS3").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Emulator Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    FileSelectorView(filePath: $rpcs3Path)
                                        .frame(maxWidth: 600)
                                        .onChange(of: rpcs3Path, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "rpcs3Path")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Section(header: Text("Xenia").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Emulator Path:")
                                        .frame(width: 120, alignment: .leading)
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Spacer()
                                    FileSelectorView(filePath: $xeniaPath)
                                        .frame(maxWidth: 600)
                                        .onChange(of: xeniaPath, perform: { newValue in
                                            UserDefaults.standard.set(newValue, forKey: "xeniaPath")
                                        })
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    
                    Section(header: Text("Images").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Logos Directory:")
                                    .frame(width: 200, alignment: .leading)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Spacer()
                                DirectorySelectorView(directoryPath: $logosDirectory)
                                    .frame(maxWidth: 400)
                                    .onChange(of: logosDirectory, perform: { newValue in
                                        UserDefaults.standard.set(newValue, forKey: "logosDirectory")
                                    })
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Section(header: Text("Videos").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Splash Screens Directory:")
                                    .frame(width: 200, alignment: .leading)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                Spacer()
                                DirectorySelectorView(directoryPath: $splashScreensDirectory)
                                    .frame(maxWidth: 400)
                                    .onChange(of: splashScreensDirectory, perform: { newValue in
                                        UserDefaults.standard.set(newValue, forKey: "splashScreensDirectory")
                                    })
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                .padding(20)

                    VStack(alignment: .leading) {
                        Section(header: Text("Available Platforms").bold().padding(.top,20).foregroundColor(isDarkMode ? .white : .black)) {
                            LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading), GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                ForEach(selectedPlatforms.keys.sorted(), id: \.self) { platform in
                                    Toggle(platform, isOn: Binding(
                                        get: { self.selectedPlatforms[platform, default: false] },
                                        set: { newValue in
                                            self.selectedPlatforms[platform] = newValue
                                            UserDefaults.standard.set(self.selectedPlatforms, forKey: "selectedPlatforms")
                                        }
                                    ))
                                    .padding(.vertical, 5)
                                    .foregroundColor(isDarkMode ? .white : .black)
                                }
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
        .navigationTitle("Platforms Settings")
    }
}

struct PlatformsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformsSettingsView()
    }
}
