//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Cesar Lopez on 4/3/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

}

extension CachedFriend : Identifiable {

}
