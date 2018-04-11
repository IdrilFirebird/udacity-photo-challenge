//
//  PhotoChallenge+CoreDataClass.swift
//  PhotoChallenge
//
//  Created by Sebastian Prokesch on 03.04.18.
//  Copyright © 2018 Sebastian Prokesch. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PhotoChallenge)
public class PhotoChallenge: NSManagedObject {

    convenience init(challenge: String, challengeDomain: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "PhotoChallenge", in: context) {
            self.init(entity: ent, insertInto: context)
            
            self.challenge = challenge
            self.challengeDomain = challengeDomain
            self.dateCreated = NSDate()
            
        } else {
            fatalError("Unable to find Entity" )
        }
    }
    
}
