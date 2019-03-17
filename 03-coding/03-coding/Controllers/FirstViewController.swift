//
//  FirstViewController.swift
//  03-coding
//
//  Created by Walter gomez on 2/4/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit
//we import the class that we will need
//the "Pr" are protocols
class FirstViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var agedLabel: UILabel!
    //get the value of the slider,thats ovious
    @IBOutlet weak var sliderAged: UISlider!
    
    var userAged = -1
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //asing the value of slider in INT type
        self.updateAgedLabel()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("returned a one value more")
        //It removes the focus to the keyboard, this allows to remove the keyboard when it needs to do that.
        textField.resignFirstResponder()
        //put "!" force to get the text even if the textField has nothing
        //Use of casting a variable, if didn't do that process, the software will crashes.
        if let theText = textField.text{
            print(theText)
            self.userName = theText
        }
        //we indicate the completicion of the textField
        return true
    }

    @IBAction func sliderAgedMove(_ sender: UISlider) {
        
        self.updateAgedLabel()
    }
    func updateAgedLabel(){
        //save the value of sender in INT type
        self.userAged = Int(self.sliderAged.value)
        
        
        //asing the value to the variable called agedlabel.
        self.agedLabel.text = "\(userAged)"
        
    }
    
    @IBAction func validateData(_ sender: Any) {
        //You can use a constant variable for to write two conditions...
        let shouldEnterTheParty = (userName == "Juan Gabriel")||(userAged >= 18)
        //and after that, use in IF/Else conditions.
        if shouldEnterTheParty {
            showAlerts(titulo: "Bienvenido a la fiesta", message: "Puedes pasar")
            self.view.backgroundColor = UIColor(red: 61.0/255.0, green: 116.0/255.0, blue: 242.0/255.0, alpha: 0.7)
        }else {
            showAlerts(titulo: "No pudes pasar", message: "Lo siento es una fiesta privada")
            self.view.backgroundColor = UIColor(red: 61.0/255.0, green: 116.0/255.0, blue: 242.0/255.0, alpha: 0.7)
        }
        /*if self.userName == "Juan Gabriel"{
            showAlerts(titulo: "EL ES JB", message: "Genial el es JB, dejalo pasar")
            self.view.backgroundColor = UIColor(red: 37.0/255.0 , green: 211.0/255.0, blue: 78.0/255.0, alpha: 0.7)
        }else{
            if userAged >= 18 {
                showAlerts(titulo: "Es mayor de edad", message: "Tiene 18 a mas anios dejalo pasar")
                self.view.backgroundColor = UIColor(red: 61.0/255.0, green: 116.0/255.0, blue: 242.0/255.0, alpha: 0.7)
            }else{
                showAlerts(titulo: "No es mayor de edad", message: "No tiene la mayoria de edad, no lo dejes pasar")
                self.view.backgroundColor = UIColor(red: 212.0/255.0, green: 59.0/255.0, blue: 54.0/255.0, alpha: 0.8)
            }*/
    }
    func showAlerts(titulo: String?, message: String?){
        //Sentation Declarate
        let alert = UIAlertController.init(title: titulo, message: message, preferredStyle: .alert)
        //create a button for exit of the alert.
        let agreeBtn = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        let cancelBtn = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        //adding the accion of the button for the alert
        alert.addAction(agreeBtn)
        alert.addAction(cancelBtn)
        //setting of the Alert controller
        self.present(alert, animated: true, completion: nil)
        }
    }





