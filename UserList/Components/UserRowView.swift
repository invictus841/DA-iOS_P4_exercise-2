//
//  UserRowView.swift
//  UserList
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import SwiftUI

struct UserRowView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                UserRowItemView(user: user)
            }
            .task {
                if viewModel.shouldLoadMoreData(currentItem: user) {
                    await viewModel.fetchUsers()
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
