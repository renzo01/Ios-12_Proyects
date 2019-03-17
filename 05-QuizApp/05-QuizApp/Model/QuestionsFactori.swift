//
//  QuestionsFactori.swift
//  05-QuizApp
//
//  Created by Walter gomez on 2/16/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import Foundation

class QuestionsFactori{
    var questionsBank : QuestionBank!
    
    init() {
        //MARKS : -Declarations of Questions
        //Eficient form
        //Question 1
        /* - Process data form manual of PropiertyList
        //secure cast
        if let path  = Bundle.main.path(forResource: "QuestionsBank", ofType: "plist"){
            if let plist = NSDictionary(contentsOfFile: path){
                let questionsData = plist["Questions"] as! [AnyObject]
                for question in questionsData {
                    if let text = question["Question"], let ans = question["Answere"], let exp = question["Explanation"] {
                        //forced type of value
                        questions.append(Question(texto: text as! String, correctAnswere: ans as! Bool, explanation: exp as! String))
                }
            }
        }
    }*/
        //Processes Automatic of PList
        //Protected the code
        do{
            if let url = Bundle.main.url(forResource: "QuestionsBank", withExtension: "plist"){
                let data = try Data(contentsOf: url)
                //get cuestion  bamk
                self.questionsBank = try PropertyListDecoder().decode(QuestionBank.self, from: data)
                //Return bytes od information
                
            }
        }
        catch{
            print(error)
        }
    }
    //validate if exist and give a question
    func getQuestionAt(index: Int) -> Question? {
        if index < 0 || index > self.questionsBank.questions.count-1{
            return nil
        }else{
            return self.questionsBank.questions[index]
        }
    }
    //ramdom index function.
    func getRamdomQuestion() -> Question? {
        let index = Int(arc4random_uniform(UInt32(self.questionsBank.questions.count)))
        return self.questionsBank.questions[index]
    }
}
