//
//  Level.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 08/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import Foundation
import CoreData

class Level: NSManagedObject {

    @NSManaged var level_number: Int16
    @NSManaged var level_score: Int16
    @NSManaged var level_type: String
    @NSManaged var level_block: Bool
    
    
    /// The convenience initializer
    convenience init()
    {
        // get context
        let context:NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription:NSEntityDescription? = NSEntityDescription.entityForName("Level", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }

}
