//
//  UserGridView.swift
//  UserList
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import SwiftUI

struct UserGridView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        UserGridItemView(user: user)
                    }
                    .task {
                        if viewModel.shouldLoadMoreData(currentItem: user) {
                            await viewModel.fetchUsers()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserGridView(viewModel: ViewModel())
}
