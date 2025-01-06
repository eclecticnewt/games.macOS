import SwiftUI

struct SettingsView: View {
    @State private var selectedSection: String = "General"
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                settingsTab(icon: "person", text: "Account", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "trophy", text: "Achievements", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "camera", text: "Media", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "opticaldisc", text: "Games", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "macmini", text: "Platforms", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "gamecontroller", text: "Controllers", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "tablecells", text: "Database", selectedSection: $selectedSection)
                Spacer()
                settingsTab(icon: "gearshape", text: "General", selectedSection: $selectedSection)
                Spacer()
            }
            .padding()
            
            Divider()
            
            VStack {
                if selectedSection == "General" {
                    GeneralSettingsView()
                } else if selectedSection == "Account" {
                    AccountSettingsView()
                } else if selectedSection == "Achievements" {
                    AchievementsSettingsView()
                } else if selectedSection == "Controllers" {
                    ControllerSettingsView()
                } else if selectedSection == "Games" {
                    GamesSettingsView()
                } else if selectedSection == "Media" {
                    MediaSettingsView()
                } else if selectedSection == "Platforms" {
                    PlatformsSettingsView()
                } else if selectedSection == "Database" {
                    DatabaseSettingsView()
                } else {
                    GeneralSettingsView()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .frame(minWidth: 700, minHeight: 400)
    }
}

struct settingsTab: View {
    let icon: String
    let text: String
    @Binding var selectedSection: String
    
    var body: some View {
        Button(action: {
            selectedSection = text
        }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(selectedSection == text ? .blue : .gray)
                Text(text)
                    .font(.caption)
                    .foregroundColor(selectedSection == text ? .blue : .gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
