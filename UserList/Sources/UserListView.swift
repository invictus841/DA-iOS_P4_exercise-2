import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView {
            if !viewModel.isGridView {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            
                            VStack(alignment: .leading) {
                                Text("\(user.name.first) \(user.name.last)")
                                    .font(.headline)
                                Text("\(user.dob.date)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onAppear {
                        if viewModel.shouldLoadMoreData(currentItem: user) {
                            viewModel.fetchUsers()
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
                            viewModel.reloadUsers()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .imageScale(.large)
                        }
                    }
                }
            } else {
                ScrollView {
                    UserGridView(viewModel: viewModel)
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
                            viewModel.reloadUsers()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .imageScale(.large)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }

    
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
