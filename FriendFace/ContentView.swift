//
//  ContentView.swift
//  FriendFace
//
//  Created by Cesar Lopez on 4/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users) { user in
                        NavigationLink {
                            UserDetailView(user: user)
                        } label: {
                            HStack {
                                Text(user.name)
                                Spacer()
                                Circle()
                                    .frame(width: 8)
                                    .foregroundColor(user.isActive ? .green : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                await fetchUsers()
            }
        }
    }
    
    func fetchUsers() async {
        if users.isEmpty {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedUsers = try decoder.decode([User].self, from: data)
                
                users = decodedUsers
                
            } catch {
                print("FAILURE")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
