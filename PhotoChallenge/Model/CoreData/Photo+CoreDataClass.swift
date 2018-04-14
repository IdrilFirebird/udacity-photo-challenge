//
//  Photo+CoreDataClass.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 03.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
    
    
    convenience init(photo: NSData, photoChallenge: PhotoChallenge, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Photo", in: context) {
            self.init(entity: ent, insertInto: context)
            self.challenge = photoChallenge
            self.dateTaken = NSDate()
            self.photo = photo
        } else {
            fatalError("Unable to find Entity" )
        }
    }
}
