import SwiftUI

struct GeneralSettingsView: View {
    
    //Search Options
    @AppStorage("searchByTitle") private var searchByTitle: Bool = false
    @AppStorage("searchByCharacter") private var searchByCharacter: Bool = false
    @AppStorage("searchByDescription") private var searchByDescription: Bool = false
    @AppStorage("searchByDeveloper") private var searchByDeveloper: Bool = false
    @AppStorage("searchByPublisher") private var searchByPublisher: Bool = false
    
    // Appearance settings
    @AppStorage("fontSize") private var fontSize: Double = 12.0
    @AppStorage("tileSize") private var tileSize: Double = 20.0
    @AppStorage("volume") private var volume: Double = 20.0
    @AppStorage("buttonIconStyle") private var buttonIconStyle: String = "Letters"
    @AppStorage("layoutStyle") private var layoutStyle: String = "Grid"

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isOnScreenKeyboard") private var isOnScreenKeyboard: Bool = false
    @AppStorage("isSidebarDefault") private var isSidebarDefault: Bool = false
    @AppStorage("showGameNameUnderTile") private var showGameNameUnderTile: Bool = false
    
    // Siri settings
    @AppStorage("enableSiri") private var enableSiri: Bool = false
    @AppStorage("sortOption") private var sortOption: String = "Title"
    @AppStorage("searchOptions") private var searchOptions: Bool = false
    @AppStorage("isSplashScreen") private var isSplashScreen: Bool = false

    @AppStorage("isSoundEffects") private var isSoundEffects: Bool = false
    @AppStorage("audioVolume") private var audioVolume: Bool = false
    @AppStorage("isBackgroundMusic") private var isBackgroundMusic: Bool = false

    // Game views visibility settings
    @State private var sidebarVisibility: [String: Bool] = UserDefaults.standard.dictionary(forKey: "sidebarVisibility") as? [String: Bool] ?? [
        "Recently Played": true,
        "Favorites": true,
        "Newly Added": true,
        "Random": true,
        "Multiplayer": true,
        "Online": true,
        "Downloads": true,
        "Broken": true,
        "Saves": true
    ]
    
    @State private var homeViewVisibility: [String: Bool] = UserDefaults.standard.dictionary(forKey: "homeViewVisibility") as? [String: Bool] ?? [
        "Recently Played": true,
        "Favorites": true,
        "Newly Added": true,
        "Random": true,
        "Multiplayer": true,
        "Online": true,
        "Downloads": true,
        "Broken": true,
        "Saves": true
    ]
    
    // Game views order settings
    @State private var gameViewOrder: [String: Int] = UserDefaults.standard.dictionary(forKey: "gameViewOrder") as? [String: Int] ?? [
        "Recently Played": 0,
        "Favorites": 1,
        "Newly Added": 2,
        "Random": 3,
        "Multiplayer": 4,
        "Online": 5,
        "Downloads": 6,
        "Broken": 7,
        "Saves": 8
    ]

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .top, spacing: 10) { // Horizontal layout with proper spacing
                            // Search Options Column
                            VStack(alignment: .leading) {
                                Section(header: Text("Search Options")
                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                    .bold()
                                    .padding(.bottom, 10) // Consistent bottom padding
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                        LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                            // Title toggle - disabled and grayed out
                                            Toggle("Title", isOn: $searchByTitle)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .disabled(true) // Makes it unclickable
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? Color.gray : Color.black)
                                            Toggle("Character", isOn: $searchByCharacter)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Toggle("Description", isOn: $searchByDescription)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Toggle("Developer", isOn: $searchByDeveloper)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Toggle("Publisher", isOn: $searchByPublisher)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                }
                                .padding(.horizontal, 20) // Consistent horizontal padding
                            }

                            // Corrected Sort Options Section
                            VStack(alignment: .leading) {
                                Section(header: Text("Sort Options")
                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                    .bold()
                                    .padding(.bottom, 10)
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                    LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                        ForEach(["Title", "Release Date", "Added Date", "Last Played Date", "Favorited"], id: \.self) { option in
                                            HStack {
                                                Image(systemName: sortOption == option ? "largecircle.fill.circle" : "circle")
                                                    .foregroundColor(sortOption == option ? .blue : .gray)
                                                    .onTapGesture {
                                                        sortOption = option
                                                    }
                                                Text(option)
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                                    .onTapGesture {
                                                        sortOption = option
                                                    }
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 20) // Ensure alignment matches other sections
                        
                        HStack(alignment: .top, spacing: 20) {
                            // Appearance Column
                            VStack(alignment: .leading) {
                                Section(header: Text("Appearance")
                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                    .bold()
                                    .padding(.bottom, 10)
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                    LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                        Toggle("Dark Mode", isOn: $isDarkMode)
                                            .font(.system(size: CGFloat(fontSize * 1.5)))
                                            .padding(.vertical, 5)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Toggle("On-Screen Keyboard", isOn: $isOnScreenKeyboard)
                                            .font(.system(size: CGFloat(fontSize * 1.5)))
                                            .padding(.vertical, 5)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Toggle("Default Sidebar", isOn: $isSidebarDefault)
                                            .font(.system(size: CGFloat(fontSize * 1.5)))
                                            .padding(.vertical, 5)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Toggle("Show Game Names", isOn: $showGameNameUnderTile)
                                            .font(.system(size: CGFloat(fontSize * 1.5)))
                                            .padding(.vertical, 5)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Toggle("Splash Screen", isOn: $isSplashScreen)
                                            .font(.system(size: CGFloat(fontSize * 1.5)))
                                            .padding(.vertical, 5)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }

                            // Search Options Column
                            VStack(alignment: .leading) {
                                Section(header: Text("Audio")
                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                    .bold()
                                    .padding(.bottom, 10) // Consistent bottom padding
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                        LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                            Toggle("Enable Siri", isOn: $enableSiri)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Toggle("Enable Music", isOn: $isBackgroundMusic)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                            Toggle("Sound Effects", isOn: $isSoundEffects)
                                                .font(.system(size: CGFloat(fontSize * 1.5)))
                                                .padding(.vertical, 5)
                                                .foregroundColor(isDarkMode ? .white : .black)
                                        }
                                    }

                                HStack(spacing: 10) { // Reduce horizontal spacing between elements
                                    Text("Volume")
                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                        .frame(width: 60, alignment: .leading) // Adjust label width
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Slider(value: $volume, in: 10...20, step: 1)
                                        .accentColor(isDarkMode ? .gray : .blue)
                                        .frame(width: 120) // Set the slider width to 50
                                }
                                .padding(.vertical, 10)
                            }
                            .padding(.horizontal, 20) // Consistent horizontal padding

                        }
                        .padding(.top, 20)

                        
                        HStack(alignment: .top, spacing: 20) {
                            
                            // Button Icons Column
                            VStack(alignment: .leading) {
                                Section(header: Text("Button Icons")
                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                    .bold()
                                    .padding(.bottom, 10)
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                    LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                        ForEach(["Letters", "Symbols", "None"], id: \.self) { iconStyle in
                                            HStack {
                                                Image(systemName: buttonIconStyle == iconStyle ? "largecircle.fill.circle" : "circle")
                                                    .foregroundColor(buttonIconStyle == iconStyle ? .blue : .gray)
                                                    .onTapGesture {
                                                        buttonIconStyle = iconStyle
                                                    }
                                                Text(iconStyle)
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                                    .onTapGesture {
                                                        buttonIconStyle = iconStyle
                                                    }
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            // Layout Style Column
                            VStack(alignment: .leading) {
                                Section(header: Text("Layout Style")
                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                    .bold()
                                    .padding(.bottom, 10)
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                    LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 10) {
                                        ForEach(["Grid", "Carousel"], id: \.self) { style in
                                            HStack {
                                                Image(systemName: layoutStyle == style ? "largecircle.fill.circle" : "circle")
                                                    .foregroundColor(layoutStyle == style ? .blue : .gray)
                                                    .onTapGesture {
                                                        layoutStyle = style
                                                    }
                                                Text(style)
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                                    .font(.system(size: CGFloat(fontSize * 1.5)))
                                                    .onTapGesture {
                                                        layoutStyle = style
                                                    }
                                            }
                                            .padding(.vertical, 5)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                    .padding(20)
                    
                    VStack(alignment: .leading) {
                        Section(header: Text("Game Views").bold().padding(.top, 20).foregroundColor(isDarkMode ? .white : .black).font(.system(size: CGFloat(fontSize * 1.5)))) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(" ").frame(width: 150, alignment: .leading) // Empty space to align columns
                                    Spacer()
                                    Text("Sidebar").frame(width: 80, alignment: .center)
                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Text("Home View").frame(width: 80, alignment: .center)
                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                        .foregroundColor(isDarkMode ? .white : .black)
                                    Text("Sort Order").frame(width: 120, alignment: .center)
                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                        .foregroundColor(isDarkMode ? .white : .black)
                                }
                                .padding(.bottom, 5)
                                
                                ForEach(gameViewOrder.sorted(by: { $0.value < $1.value }).map { $0.key }, id: \.self) { key in
                                    HStack {
                                        Text(key)
                                            .font(.system(size: CGFloat(fontSize * 1.5))) // Apply dynamic font size
                                            .frame(width: 150, alignment: .leading)
                                            .foregroundColor(isDarkMode ? .white : .black)
                                        Spacer()
                                        Toggle("", isOn: Binding(
                                            get: { sidebarVisibility[key] ?? true },
                                            set: { newValue in
                                                sidebarVisibility[key] = newValue
                                                UserDefaults.standard.set(sidebarVisibility, forKey: "sidebarVisibility")
                                            }
                                        ))
                                        .frame(width: 80, alignment: .center)
                                        Toggle("", isOn: Binding(
                                            get: { homeViewVisibility[key] ?? true },
                                            set: { newValue in
                                                homeViewVisibility[key] = newValue
                                                UserDefaults.standard.set(homeViewVisibility, forKey: "homeViewVisibility")
                                            }
                                        ))
                                        .frame(width: 80, alignment: .center)
                                        HStack(spacing: 5) {
                                            Button(action: {
                                                moveView(key: key, direction: .up)
                                            }) {
                                                Image(systemName: "arrow.up")
                                                    .font(.system(size: CGFloat(fontSize * 1.5))) // Apply dynamic font size
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                            }
                                            .disabled(gameViewOrder[key] == 0)

                                            Button(action: {
                                                moveView(key: key, direction: .down)
                                            }) {
                                                Image(systemName: "arrow.down")
                                                    .font(.system(size: CGFloat(fontSize * 1.5))) // Apply dynamic font size
                                                    .foregroundColor(isDarkMode ? .white : .black)
                                            }
                                            .disabled(gameViewOrder[key] == gameViewOrder.count - 1)
                                        }
                                        .frame(width: 120, alignment: .center)
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        
                        // Sliders and Previews
                            HStack(alignment: .top, spacing: 20) {
                                Section(header: Text("")
                                    .bold()
                                    .padding(.bottom, 10)
                                    .foregroundColor(isDarkMode ? .white : .black)) {
                                        
                                        
                                        VStack(alignment: .leading, spacing: 20) {
                                                                                           
                                                // Font Size Slider
                                                HStack(spacing: 10) {
                                                    Text("Font Size")
                                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                                        .frame(width: 60, alignment: .leading)
                                                        .foregroundColor(isDarkMode ? .white : .black)
                                                    Slider(value: $fontSize, in: 10...20, step: 1)
                                                        .accentColor(isDarkMode ? .gray : .blue)
                                                        .frame(width: 120)
                                                }
                                            
                                                
                                                
                                                // Tile Size Slider
                                                HStack(spacing: 10) {
                                                    Text("Tile Size")
                                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                                        .frame(width: 60, alignment: .leading)
                                                        .foregroundColor(isDarkMode ? .white : .black)
                                                    Slider(value: $tileSize, in: 10...20, step: 1)
                                                        .accentColor(isDarkMode ? .gray : .blue)
                                                        .frame(width: 120)
                                                }
                                                
                                            }
                                            
                                        }
                                
                                HStack(alignment: .top, spacing: 20) {

                                          
                                    // Font Size Preview
                                    Text("A")
                                        .font(.system(size: CGFloat(fontSize * 1.5)))
                                        .foregroundColor(isDarkMode ? .white : .black)
                                        .frame(width: 50, height: 50, alignment: .center)
                                    
                                        VStack(alignment: .leading, spacing: 20) {
                                            
                                            // Tile Size Preview
                                            Rectangle()
                                                .fill(isDarkMode ? Color.gray.opacity(0.3) : Color.gray.opacity(0.5))
                                                .frame(width: tileSize * 7.5, height: tileSize * 7.5)
                                                .cornerRadius(8)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(isDarkMode ? Color.white.opacity(0.6) : Color.black.opacity(0.3), lineWidth: 1)
                                                )
                                        }
                                    }
                            }
                            .padding(.vertical, 75)
                    }
                    .frame(width: (geometry.size.width / 2) - 30, alignment: .leading)
                    .padding(20)
                }
                .frame(width: geometry.size.width)
            }
        }
        .navigationTitle("General Settings")
    }

    private func moveView(key: String, direction: MoveDirection) {
        guard let currentIndex = gameViewOrder[key] else { return }

        switch direction {
        case .up:
            if currentIndex > 0 {
                let previousKey = gameViewOrder.first { $0.value == currentIndex - 1 }?.key
                gameViewOrder[key] = currentIndex - 1
                if let previousKey = previousKey {
                    gameViewOrder[previousKey] = currentIndex
                }
            }
        case .down:
            if currentIndex < gameViewOrder.count - 1 {
                let nextKey = gameViewOrder.first { $0.value == currentIndex + 1 }?.key
                gameViewOrder[key] = currentIndex + 1
                if let nextKey = nextKey {
                    gameViewOrder[nextKey] = currentIndex
                }
            }
        }
        UserDefaults.standard.set(gameViewOrder, forKey: "gameViewOrder")
    }

    enum MoveDirection {
        case up
        case down
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}

struct RadioButtonGroup: View {
    @Binding var selected: String
    var options: [(String, [AnyView])]
    var isDarkMode: Bool // Add this to pass the isDarkMode value

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(options, id: \.0) { option in
                HStack {
                    Image(systemName: self.selected == option.0 ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(self.selected == option.0 ? .blue : .gray)
                        .onTapGesture {
                            self.selected = option.0
                        }
                    Text(option.0)
                        .foregroundColor(isDarkMode ? .white : .black) // Use the passed isDarkMode value here
                        .onTapGesture {
                            self.selected = option.0
                        }
                    HStack(spacing: 5) {
                        ForEach(option.1.indices, id: \.self) { index in
                            option.1[index]
                        }
                    }
                    .padding(.leading, 10)
                }
                .padding(.vertical, 5)
            }
        }
    }
}

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
