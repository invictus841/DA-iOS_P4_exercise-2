import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.isGridView {
                    UserRowView(viewModel: viewModel)
                    
                } else {
                    ScrollView {
                        UserGridView(viewModel: viewModel)
                    }
                    
                }
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: $viewModel.isGridView, label: Text("Display")) {
                        Image(systemName: "rectangle.grid.1x2.fill")
                            .tag(true)
                            .accessibilityLabel(Text("Grid view"))
                        Image(systemName: "list.bullet")
                            .tag(false)
                            .accessibilityLabel(Text("List view"))
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await viewModel.reloadUsers()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
    }

    
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
