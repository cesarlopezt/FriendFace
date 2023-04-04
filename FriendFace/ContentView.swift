//
//  ContentView.swift
//  FriendFace
//
//  Created by Cesar Lopez on 4/2/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.isActive, order: .reverse),
        SortDescriptor(\.name)
    ]) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(cachedUsers) { user in
                        NavigationLink {
                            UserDetailView(user: user)
                        } label: {
                            HStack {
                                Text(user.wrappedName)
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
                await getUsers()
            }
        }
    }
    
    func getUsers() async {
        if cachedUsers.isEmpty {
            if let fetchedUsers = await fetchUsers() {
                await MainActor.run {
                    for user in fetchedUsers {
                        let newUser = CachedUser(context: moc)
                        newUser.id = user.id
                        newUser.name = user.name
                        newUser.isActive = user.isActive
                        newUser.age = Int16(user.age)
                        newUser.company = user.company
                        newUser.email = user.email
                        newUser.address = user.address
                        newUser.about = user.about
                        newUser.registered = user.registered
                        newUser.tags = user.tags.joined(separator: ",")
                        
                        for friend in user.friends {
                            let newFriend = CachedFriend(context: moc)
                            newFriend.name = friend.name
                            newFriend.id = friend.id
                            newFriend.user = newUser
                        }
                    }
                    try? moc.save()
                }
            }
        }
    }
    
    func fetchUsers() async -> [User]? {
        print("FETCHING")
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            return decodedUsers
            
        } catch {
            print("FAILURE")
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
