import SwiftUI

struct AchievementsSettingsView: View {
    @State private var apiToken: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Achievements")
                    .bold()
                    .padding(.top, 20)
                    .padding(.leading, 20)

                Form {
                    Section {
                        HStack {
                            SecureField("Enter API Token", text: $apiToken)
                                .frame(maxWidth: 500)
                        }
                    }
                }
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationTitle("Achievements Settings")
    }
}

struct AchievementsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsSettingsView()
    }
}
