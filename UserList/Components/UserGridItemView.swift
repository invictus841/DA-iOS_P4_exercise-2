//
//  UserGridItemView.swift
//  UserList
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import SwiftUI

struct UserGridItemView: View {
    let user: User
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.picture.medium)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            
            Text("\(user.name.first) \(user.name.last)")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
    }
}

//#Preview {
//    UserGridItemView()
//}
