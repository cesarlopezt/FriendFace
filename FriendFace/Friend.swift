//
//  Friend.swift
//  FriendFace
//
//  Created by Cesar Lopez on 4/2/23.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
