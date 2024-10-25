//
//  ViewModelTests.swift
//  UserListTests
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import XCTest
import Testing
@testable import UserList

struct ViewModelTests {


    class FakeListRepository: ListRepository {
        var fetchUsersCallCount: Int = 0
        
        func fetchUsers(quantity: Int) async throws -> [User] {
            fetchUsersCallCount += 1
            
            return []
        }
    }
    
    @Test func testProperties_whenInitialized_areSet() {
        
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
    
    @Test func testReloadUsers() {
        
        
        let repository = FakeListRepository()
    
        
        // Ce qu'on teste
        let sut = ViewModel(repository: repository)
        
        sut.reloadUsers()
        
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertEqual(repository.fetchUsersCallCount, 1)
    }
    
    @Test func testShouldLoadMoreData_WithLastItem() {
        
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
    
    @Test func testShouldLoadMoreData_WithNotLastItem() {
        
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
        
    
}
