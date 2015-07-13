//
//  AccessJSON.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 06/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import Foundation

class AccessJSON {
    
    
    static func  accessTheQuestion(type : String)-> String
    {
        var question = [String]()
        
        let filePath = NSBundle.mainBundle().pathForResource("Perguntas", ofType: "json")
        //let filePath = NSBundle.mainBundle().pathForResource(arq, ofType: "json")
        
        var readError : NSError?
        
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        
        let json = JSON(data:data!)
        
        for (key : String, quest: JSON ) in json["Perguntas"][type]{
            //for (key : String, quest: JSON ) in json[arq][type]{
            question.append(key)
        }
        var indexOfTheQuestion = arc4random_uniform(UInt32(question.count))
        
        return question[Int(indexOfTheQuestion)]
    }
    
    
    
    //This method access the options in of a level
    static func accessTheOptions(type : String, question : String, level : String) -> [String] {
        
        var answers = [String]()
        var arrayOfOptions = [String]()
        
        let filePath = NSBundle.mainBundle().pathForResource("Perguntas", ofType: "json")
        //let filePath = NSBundle.mainBundle().pathForResource(arq, ofType: "json")
        
        var readError : NSError?
        
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        
        let json = JSON(data:data!)
        
        for (key : String, quest: JSON ) in json["Perguntas"][type][question][level]{
            //for (key : String, quest: JSON ) in json[arq][type][question][level]{
            answers.append(key)
            
        }
        
        var indexOfTheAnswer = arc4random_uniform(UInt32(answers.count))
        
        arrayOfOptions.append(answers[Int(indexOfTheAnswer)])
        
        var indexOfTheAnswer2 = UInt32()
        
        do {
            indexOfTheAnswer2 = arc4random_uniform(UInt32(answers.count))
            
        } while(indexOfTheAnswer2 == indexOfTheAnswer)
        
        arrayOfOptions.append(answers[Int(indexOfTheAnswer2)])
        println(arrayOfOptions[0])
        println(arrayOfOptions[1])
        
        
        
        return arrayOfOptions
        
    }
    
    static func accessTheAnswers(type : String, question : String, level : String, option1 : String, option2 : String) -> Dictionary<String,Int>{
        
        var dictionaryOfAnswers = Dictionary<String,Int>()
        
        let filePath = NSBundle.mainBundle().pathForResource("Perguntas", ofType: "json")
        //let filePath = NSBundle.mainBundle().pathForResource(arq, ofType: "json")
        
        var readError : NSError?
        
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        
        let json = JSON(data:data!)
        
        var vet: [Dictionary<String, Int>] = []
        
        var dic : Dictionary<String,Int>
        
        for (var i = 0; i < json["Perguntas"][type][question][level][option1].count; i++){
            //for (var i = 0; i < json[arq][type][question][level][option1].count; i++){
            
            //dic = [String(stringInterpolationSegment: json[arq][question][level][option1][i]) : 0]
            dic = [String(stringInterpolationSegment: json["Perguntas"][type][question][level][option1][i]) : 0]
            
            
            vet.append(dic)
            println(dic)
            
        }
        
        for (var i = 0; i < json["Perguntas"][type][question][level][option2].count; i++){
            //for (var i = 0; i < json[arq][type][question][level][option2].count; i++){
            
            //dic = [String(stringInterpolationSegment: json[arq][question][level][option2][i]) : 1]
            dic = [String(stringInterpolationSegment: json["Perguntas"][type][question][level][option2][i]) : 1]
            
            vet.append(dic)
            
        }
        
        
        
        var indexOfTheQuestion : Int = Int(arc4random_uniform(UInt32(vet.count)))
        
        var i = 0
        
        while (i < 10){
            let key = vet[indexOfTheQuestion].keys
            println(key)
            let value = (vet[indexOfTheQuestion][key.array[0]])
            dictionaryOfAnswers[key.array[0]] = value
            vet.removeAtIndex(Int(indexOfTheQuestion))
            
            indexOfTheQuestion = Int(arc4random_uniform(UInt32(vet.count)))
            
            i++
            
            
            
        }
        println(dictionaryOfAnswers)
        
        return dictionaryOfAnswers
    }
    
    
}


