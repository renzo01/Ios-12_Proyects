 //
//  ViewController.swift
//  07-MathTraning
//
//  Created by Walter gomez on 3/5/19.
//  Copyright © 2019 Renzo Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drowingView: DrawingImageView!
    //references factory
    let factory = QuestionsFactory()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(factory.score)
        drowingView.delegate = self
        //title
        title = "Math training"
        
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1
    }

    func numberDrown(_ image: UIImage){
        askNextQuestion()
    }
    
    func askNextQuestion(){
        //erase the draw in imageView
        drowingView.image = nil
        
        factory.addNewQuestion()
        
        let newIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .top)
        
        let secondIndexPath = IndexPath(row: 1, section: 0)
        if let cell = tableView.cellForRow(at: secondIndexPath){
            setText(for: cell, at: secondIndexPath, to: factory.getQuestionAt(position: 1)!)
        }
    }
    
    func setText(for cell: UITableViewCell, at indexPath: IndexPath, to question: Question){
        if indexPath.row == 0{
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        }
        else{
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        }
        if let userAnswer = question.userAnswer{
            cell.textLabel?.text = "\(question.text) = \(userAnswer)"
        }else{
            cell.textLabel?.text = "\(question.text) = ?"
        }
    }
    // - MARK> UIViewDelegateDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factory.numberOfQuestion()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //delegate
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let currentQuesion = factory.getQuestionAt(position: indexPath.row){
         setText(for: cell, at: indexPath, to: currentQuesion)
        }
        return cell
    }
    // Mark: UITableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

