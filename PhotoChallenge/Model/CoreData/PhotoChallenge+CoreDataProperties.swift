//
//  PhotoChallenge+CoreDataProperties.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 03.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//
//

import Foundation
import CoreData


extension PhotoChallenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoChallenge> {
        return NSFetchRequest<PhotoChallenge>(entityName: "PhotoChallenge")
    }

    @NSManaged public var dateCreated: NSDate?
    @NSManaged public var challenge: String?
    @NSManaged public var challengeDomain: String?
    @NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for photos
extension PhotoChallenge {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}
