//
//  LevelDAO.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 08/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import Foundation
import CoreData

class LevelDAO : DatabaseManager
{
    
    static func returnAllValues() -> [Level] {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Level")
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Level] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Level]
        
        
        
        return results
    }

    
    
    
    
}
