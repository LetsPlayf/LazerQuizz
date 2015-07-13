//
//  AccessJSON.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 06/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import Foundation

class AccessJSON {
    
    
    //This method returns the question that is going to be used. It receives a string that is the area of the question.
    static func  accessTheQuestion(type : String)-> String
    {
        //The string to be returned.
        var question = [String]()
        
        //Accessing the JSON.
        let filePath = NSBundle.mainBundle().pathForResource("Perguntas", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        
        //Getting all the questions in an area and inserting in an array.
        for (key : String, quest: JSON ) in json["Perguntas"][type]{
            //for (key : String, quest: JSON ) in json[arq][type]{
            question.append(key)
        }
        
        //Creating a random variable.
        var indexOfTheQuestion = arc4random_uniform(UInt32(question.count))
        
        //Returning a random question.
        return question[Int(indexOfTheQuestion)]
    }
    
    
    
    //This method accesses the level of the questions and returns the right and left options in the game.
    static func accessTheOptions(type : String, question : String, level : String) -> [String] {
        
        var answers = [String]()
        var arrayOfOptions = [String]()
        
        
        //Accessing the JSON
        let filePath = NSBundle.mainBundle().pathForResource("Perguntas", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        for (key : String, quest: JSON ) in json["Perguntas"][type][question][level]{

            answers.append(key)
            
        }
        
        //Sorting the two options.
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
    
    
    
    //Method to get the answers. It returns a dictionary with a string and an int.
    static func accessTheAnswers(type : String, question : String, level : String, option1 : String, option2 : String) -> Dictionary<String,Int>{
        
        //The dictionary that is going to be returned
        var dictionaryOfAnswers = Dictionary<String,Int>()
        
        //Accessing the JSON
        let filePath = NSBundle.mainBundle().pathForResource("Perguntas", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        //Auxiliary variables to create the Dictionary that is going to be returned.
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
            println(dic)
        }
        
        
        //Variable to randomize the selected values to be used in the dictionary.
        var indexOfTheQuestion : Int = Int(arc4random_uniform(UInt32(vet.count)))
        
        var i = 0
        println(vet)
        let max = vet.count/2
        //Getting all the keys and values of the auxiliary variables and putting in the Dictionary
        for(var i = 0; i < max;i++){
        //while (i < vet.count/2){
            let key = vet[indexOfTheQuestion].keys
            let value = (vet[indexOfTheQuestion][key.array[0]])
            dictionaryOfAnswers[key.array[0]] = value
            vet.removeAtIndex(Int(indexOfTheQuestion))
            
            indexOfTheQuestion = Int(arc4random_uniform(UInt32(vet.count)))
            println(i)
            
            
            
        }
        println(dictionaryOfAnswers)
        
        return dictionaryOfAnswers
    }
    
    
}


