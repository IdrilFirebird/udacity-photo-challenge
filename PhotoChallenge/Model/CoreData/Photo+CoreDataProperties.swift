//
//  Photo+CoreDataProperties.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 03.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var dateTaken: NSDate?
    @NSManaged public var challenge: PhotoChallenge?

}
