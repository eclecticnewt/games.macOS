import SwiftUI

struct DatabaseSettingsView: View {
    @ObservedObject var viewModel = DatabaseViewModel()

    var body: some View {
        VStack {
            List {
                Section(header: headerView) {
                    ForEach(viewModel.filteredGames.indices, id: \.self) { index in
                        HStack {
                            ForEach(viewModel.headers, id: \.self) { header in
                                TextField(
                                    "",
                                    text: Binding(
                                        get: { viewModel.value(for: header, in: viewModel.filteredGames[index]) },
                                        set: { newValue in
                                            viewModel.updateLocalValue(for: header, with: newValue, in: index)
                                        }
                                    )
                                )
                                .textFieldStyle(PlainTextFieldStyle())
                                .frame(width: viewModel.columnWidth(for: header), alignment: .leading)
                                .padding(.horizontal, 5)
                                .background(index % 2 == 0 ? Color.gray.opacity(0.1) : Color.clear)
                            }
                        }
                    }
                }
            }

            Button("Save All Changes") {
                viewModel.saveAllChanges()
            }
            .padding()
        }
        .padding()
        .navigationTitle("Database Settings")
        .onAppear {
            viewModel.loadGames()
        }
    }

    private var headerView: some View {
        HStack {
            ForEach(viewModel.headers, id: \.self) { header in
                Text(header.capitalized)
                    .bold()
                    .frame(width: viewModel.columnWidth(for: header), alignment: .leading)
                    .padding(.horizontal, 5)
                    .background(Color.gray.opacity(0.2))
            }
        }
    }
}
