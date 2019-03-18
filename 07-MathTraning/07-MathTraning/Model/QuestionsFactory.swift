//
//  QuestionsFactory.swift
//  07-MathTraning
//
//  Created by Walter gomez on 3/10/19.
//  Copyright © 2019 Renzo Gomez. All rights reserved.
//

import Foundation

class QuestionsFactory{
    //always put var in private.... if you want use var in another controller , well use public.
    private var questions = [Question]()
    //only readilng
    //(set) =  setter
    private(set) var score: Int = 0
    
    
    init() {
        self.addNewQuestion()
    }
    func addNewQuestion(){
        questions.insert(createQuestions(), at: 0)

    }
    
    func getQuestionAt(position : Int) -> Question? {
        if (position < 0 || position >= questions.count) {
            return nil
        }
            return self.questions[position]
    }
    func numberOfQuestion() -> Int{
        return questions.count
    }
    func createQuestions() -> Question{
        var question = ""
        var correctAnswer = 0
        while true{
            let firstNumber = Int.random(in: 0...9)
            let secondNumber = Int.random(in: 0...9)
            if Bool.random(){
                //add operation
                let result = firstNumber + secondNumber
                if result < 10{
                    question = "\(firstNumber) + \(secondNumber)"
                    correctAnswer = result
                    //important close the loop
                    break
                }
            }else{
                // rest opertion
                let result = firstNumber - secondNumber
                if result >= 0 {
                    question = "\(firstNumber) - \(secondNumber)"
                    correctAnswer = firstNumber - secondNumber
                    break
                }
            }
            
        }
        return Question(text: question, Answer : correctAnswer, userAnswer: nil)
    }
    func updateQuestion (at index: Int, with answer: Int){
        questions[index].userAnswer = answer
    }
    func validateQuestion (at index: Int){
        if self.questions[index].userAnswer == self.questions[index].Answer{
            self.score += 100 
        }
    }
}
