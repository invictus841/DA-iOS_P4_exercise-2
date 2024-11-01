//
//  ViewModel.swift
//  UserList
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import Foundation

class ViewModel: ObservableObject {
    // TODO: - Those properties should be viewModel's OutPuts
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var isGridView = false
    @Published var isError = false
    
    // TODO: - The property should be declared in the viewModel
    let repository : ListRepository
    
    init(repository: ListRepository = UserListRepository()) {
        self.repository = repository
    }
    
    // TODO: - Should be a viewModel's input
    
    @MainActor
    func fetchUsers() async {
        isLoading = true
         
            do {
                let users = try await repository.fetchUsers(quantity: 20)
                self.users.append(contentsOf: users)
                isLoading = false
            } catch {
//                print("Error fetching users: \(error.localizedDescription)")
                isError = true
            }
        
    }

    // TODO: - Should be an OutPut
    func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }

    // TODO: - Should be a viewModel's input
    func reloadUsers() async {
        users.removeAll()
        await fetchUsers()
    }
}
