//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Cesar Lopez on 4/2/23.
//

import SwiftUI

struct UserDetailView: View {
    var user: CachedUser
    
    var body: some View {
        Form {
            Section("Personal") {
                HStack {
                    Text("Age")
                    Divider()
                    Text(user.age, format: .number)
                }
                HStack {
                    Text("Address")
                    Divider()
                    Text(user.wrappedAddress)
                }
            }

            Section("Work") {
                HStack {
                    Text("Company")
                    Divider()
                    Text(user.wrappedCompany)
                }
                HStack {
                    Text("Email")
                    Divider()
                    Text(user.wrappedEmail)
                }
            }
            
            Section {
                Text(user.wrappedAbout)
            } header: {
                Label("About", systemImage: "info.circle")
            }
            
            Section {
                NavigationLink {
                    List(user.friendsArray) { friend in
                        Text(friend.wrappedName)
                    }
                    .navigationTitle("\(user.wrappedName)'s Friends")
                } label: {
                    Text("Friends")
                }
                NavigationLink {
                    List(user.tagsArray, id: \.self) {
                        Text($0)
                    }
                    .navigationTitle("\(user.wrappedName)'s Tags")
                } label: {
                    Text("Tags")
                }
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing
            ) {
                Circle()
                    .foregroundColor(user.isActive ? .green : .gray)
            }
        }
    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var user = User(
//        id: UUID(),
//        isActive: true,
//        name: "Ramon Pena",
//        age: 34,
//        company: "Google",
//        email: "rpena@google.com",
//        address: "3154 N. Washington St",
//        about: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//        registered: Date.now,
//        tags: ["Lorem", "Ipsum", "Renao", "Dummy"],
//        friends: [
//            Friend(id: UUID(), name: "Rafael Velazquez"),
//            Friend(id: UUID(), name: "Alberto Lopez")
//        ]
//    )
//
//    static var previews: some View {
//        NavigationView {
//            UserDetailView(user: user)
//        }
//    }
//}
