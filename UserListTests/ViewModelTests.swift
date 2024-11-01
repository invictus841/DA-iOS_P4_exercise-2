//
//  ViewModelTests.swift
//  UserListTests
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import XCTest
import Testing
@testable import UserList

class ViewModelTests: XCTestCase {


    class FakeListRepository: ListRepository {
        var fetchUsersCallCount: Int = 0
        var result: Result<[User], Error>
        
        init(result: Result<[User], Error> = .success([])) {
            self.result = result
        }
        
        
        func fetchUsers(quantity: Int) async throws -> [User] {
            fetchUsersCallCount += 1
            
            return try result.get()
        }
    }
    
     func testProperties_whenInitialized_areSet() {
        
        let repository = FakeListRepository()
    
        
        // Ce qu'on teste
        let sut = ViewModel(repository: repository)
        
        // Resultat
        XCTAssertTrue(sut.users.isEmpty)
        // Resultat
        XCTAssertFalse(sut.isGridView)
        // Resultat
        XCTAssertFalse(sut.isLoading)
    }
    
    func testReloadUsers() async {
        
        
        let repository = FakeListRepository()
    
        
        // Ce qu'on teste
        let sut = ViewModel(repository: repository)
        
        await sut.reloadUsers()
        
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertEqual(repository.fetchUsersCallCount, 1)
    }
    
     func testShouldLoadMoreData_WithLastItem() {
        
        let repository = FakeListRepository()
        let sut = ViewModel(repository: repository)
        
        let firstUser = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mr", first: "John", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1990-01-01", age: 20),
            picture: UserListResponse.User.Picture(large: "url", medium: "url", thumbnail: "url")
        ))
        
        let lastUser = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mrs", first: "Jane", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1992-01-01", age: 20),
            picture: UserListResponse.User.Picture(large: "url", medium: "url", thumbnail: "url")
        ))
        
        sut.users = [firstUser, lastUser]
        
        let result = sut.shouldLoadMoreData(currentItem: lastUser)
        
        XCTAssertTrue(result)
    }
    
   func testShouldLoadMoreData_WithNotLastItem() {
        
        let repository = FakeListRepository()
        let sut = ViewModel(repository: repository)
        
        let firstUser = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mr", first: "John", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1990-01-01", age: 20),
            picture: UserListResponse.User.Picture(large: "url", medium: "url", thumbnail: "url")
        ))
        
        let lastUser = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mrs", first: "Jane", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1992-01-01", age: 20),
            picture: UserListResponse.User.Picture(large: "url", medium: "url", thumbnail: "url")
        ))
        
        sut.users = [firstUser, lastUser]
        
        let result = sut.shouldLoadMoreData(currentItem: firstUser)
        
        XCTAssertFalse(result)
    }
        
    
    func testShouldLoadMoreData_EmptyUsers() {
        
        let repository = FakeListRepository()
        let sut = ViewModel(repository: repository)
        
        let testUser = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mrs", first: "Jane", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1992-01-01", age: 20),
            picture: UserListResponse.User.Picture(large: "url", medium: "url", thumbnail: "url")
        ))
        
        sut.users = []
        
        let result = sut.shouldLoadMoreData(currentItem: testUser)
        
        XCTAssertFalse(result)
    }
    
    func testShouldNotFetch_Error() async {
        
        let repository = FakeListRepository(result: .failure(NSError()))
        let sut = ViewModel(repository: repository)
        
        
        await sut.fetchUsers()
        
        XCTAssertTrue(sut.isError)
    }
    
}
