//
//  LevelServices.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 08/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import Foundation


class LevelServices {
    
    
    static func createLevel (number : Int, score : Int, type : String, block : Bool){
        
        var level : Level = Level()
        
        level.level_number = Int16(number)
        level.level_score = Int16(score)
        level.level_type = type
        level.level_block = block
        
        
        LevelDAO.insert(level)
        
        
    }
    

    static func alterBlock(level : Level){
        
        level.level_block = false
        LevelDAO.update()
        
    }
    
    
    
}