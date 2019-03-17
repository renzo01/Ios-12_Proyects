//
//  ViewController.swift
//  05-QuizApp
//
//  Created by Walter gomez on 2/14/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Marks: -Objects modificates
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelQuestionNumber: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var progressView: UIView!
    
    var currentScore = 0
    var currentQuestionID = 0
    var correctQuestionAnswered = 0
    
    let factory = QuestionsFactori()
    
    var currentQuestion : Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.stratGame()
    }
    //function what save the empty value of variables for load in 'viewDidLoad'
    func stratGame() {
        currentScore = 0
        currentQuestionID = 0
        correctQuestionAnswered = 0
        
        //shuffle the cuestions
        self.factory.questionsBank.questions.shuffle()
        
        askNextQuestion()
        
        self.updateUIElement()
    }
    
    func askNextQuestion () {
        if let nextQuestion = factory.getQuestionAt(index: currentQuestionID){
            self.currentQuestion = nextQuestion
            self.labelQuestion.text = self.currentQuestion.QuestionText
            self.currentQuestionID += 1
        } else {
            //If not exist more questions the Quizz was end, in few words the game is over.
            self.gameOver()
        }
    }
    
    func gameOver() {
        let alert = UIAlertController(title: NSLocalizedString("gane.over.title", comment: "The title of game over"), message: String(NSLocalizedString("game.over.messag1", comment: "Message : Haz acertado")) + " \(self.correctQuestionAnswered) / \(self.currentQuestionID). " + String(NSLocalizedString("game.over.message2", comment: "Message : Prueba otra vez")), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default) { (_) in
            self.stratGame()
        }
        alert.addAction(okAlert)
        present(alert,animated: true, completion: nil )
    }
    
    func updateUIElement()  {
        self.labelScore.text = String(NSLocalizedString("score.text", comment: "Message : Puntacion")) + String(self.currentScore)
        self.labelQuestionNumber.text = String(self.currentQuestionID)  + "/" + String(self.factory.questionsBank.questions.count)
        
        for contrains in self.progressView.constraints {
            if contrains.identifier == "barWidth"{
                contrains.constant  = self.view.frame.size.width / CGFloat(self.factory.questionsBank.questions.count)*CGFloat(self.currentQuestionID)
            }
        }
        
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        let isCorrect : Bool
        if (sender.tag == 1){
            //if the user pressed 'verdadero'
            isCorrect = (self.currentQuestion.Answere == true)
        }else {
            //if the user pressed  'false'
            isCorrect = (self.currentQuestion.Answere == false)
        }
        
        //var title = "Haz Fallado"
        
        if (isCorrect){
            self.correctQuestionAnswered += 1
            //title = "Enhorabuena! "
            self.currentScore += 100 * self.correctQuestionAnswered
            ProgressHUD.showSuccess(String(NSLocalizedString("question.ok", comment: "Message : ¡EnHorabuena!")), interaction: true )
        }else{
            ProgressHUD.showError(String(NSLocalizedString("question.ko", comment: "Message : Lastima...")) + "\n" + self.currentQuestion.Explanation, interaction: true)
        }
        self.askNextQuestion()
        self.updateUIElement()
        /*/make a alert controller
        let alert = UIAlertController(title: title, message: self.currentQuestion.Explanation, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: .default) { (_) in
             self.askNextQuestion()
             self.updateUIElement()
            
        }
        alert.addAction(okAction)
        //show the alert
        present(alert,animated: true,completion: nil)
        */
    }
    //force the light theme for bar status
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    //force hidden for bar status
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

