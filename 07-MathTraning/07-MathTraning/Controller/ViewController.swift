 //
//  ViewController.swift
//  07-MathTraning
//
//  Created by Walter gomez on 3/5/19.
//  Copyright © 2019 Renzo Gomez. All rights reserved.
//

import UIKit
//created for able to work with machine learning, models...
import Vision
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drowingView: DrawingImageView!
    //for using the data of IA
    var nistModel = MnistModel()
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
        //1. resize the user image to an image 299 x 299, size what request the model
        let modelSize = 299
        //scaler....
        UIGraphicsBeginImageContextWithOptions(CGSize(width: modelSize, height: modelSize), true, 1.0)
        //indicate UIViewController works in this space.
        image.draw(in: CGRect(x: 0, y: 0, width: modelSize, height: modelSize))
        //only use "!" if you are sure existe the option.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        //close the context
        UIGraphicsEndImageContext()
        //2. UIImage -> CImage
        guard let ciImage = CIImage(image: newImage) else {
            fatalError("Error when convert UIImage to CImage")
        }
        //3. load the model in vision.
        guard let model = try? VNCoreMLModel(for: nistModel.model) else{
            fatalError("No se a podido preparar el modelo")
        }
        //4. make a request of VNCoreMLRequest
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
             //5. when ditected the image, we have to validate the answere
            guard let result = request.results as?[VNClassificationObservation],
                let prediction = result.first else{
                    fatalError("Error al hacer la prediccion. \(error?.localizedDescription ?? "error desconocido")")
            }
            DispatchQueue.main.async {
                //El resultado es la etiqueta de la classe donde el modelo ha catalogado nuestra imagen
                let result = Int(prediction.identifier) ?? 0
                //asssing user answer for actual question
                self?.factory.updateQuestion(at: 0, with: result)
                //validate if the userAnswer is correct.
                self?.factory.validateQuestion(at: 0)
                //create a new Question.
                self?.askNextQuestion()
            }
        }
        //6. connect everything in an object type VNRequestHandler
        let handler = VNImageRequestHandler(ciImage: ciImage)
        //execute the request in a second thread for dont stop the UI
        DispatchQueue.global(qos: .userInteractive).async {
            do{
                try handler.perform([request])
            }catch{
                print(error.localizedDescription)
            }
        }
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

