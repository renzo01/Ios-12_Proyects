//
//  Question.swift
//  05-QuizApp
//
//  Created by Walter gomez on 2/16/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import Foundation
//with this protocol , its possible create a fancy validation.
class Question : CustomStringConvertible, Codable{
    
    let QuestionText : String
    let Answere : Bool
    let Explanation : String
    
    //Enumarate to link the variable with Propierty List
    enum CodingKeys : String, CodingKey{
        case QuestionText = "Question"
        case Answere = "Answere"
        case Explanation = "Explanation"
    }
    //Hybrid of Metchod with variable
    var description : String{
        //form for validation.
        let respuesta = [Answere ? "verdadero":"falsa"]
        return """
        Pregunta:
            -\(QuestionText)
            Respuesta: -\(respuesta)
            Explicacion : -\(Explanation)
        """
    }
    //initializer
    init(texto: String,correctAnswere : Bool, explanation : String) {
        self.QuestionText = texto
        self.Answere = correctAnswere
        self.Explanation = explanation
    }
}
struct QuestionBank : Codable {
    //this varable have to same name of the propiertyList
    var questionsCe : [Question]
}

