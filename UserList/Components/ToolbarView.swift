//
//  ToolbarView.swift
//  UserList
//
//  Created by Alexandre Talatinian on 18/10/2024.
//

import SwiftUI

//struct ToolbarView: View {
//    @ObservedObject var viewModel: ViewModel
//    
//    var body: some View {
//        VStack {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Picker(selection: $viewModel.isGridView, label: Text("Display")) {
//                    Image(systemName: "rectangle.grid.1x2.fill")
//                        .tag(true)
//                        .accessibilityLabel(Text("Grid view"))
//                    Image(systemName: "list.bullet")
//                        .tag(false)
//                        .accessibilityLabel(Text("List view"))
//                }
//                .pickerStyle(SegmentedPickerStyle())
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    viewModel.reloadUsers()
//                }) {
//                    Image(systemName: "arrow.clockwise")
//                        .imageScale(.large)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ToolbarView(viewModel: ViewModel())
//}
