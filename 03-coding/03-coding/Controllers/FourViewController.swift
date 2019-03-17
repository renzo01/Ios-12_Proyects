//
//  FourViewController.swift
//  03-coding
//
//  Created by Walter gomez on 2/13/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {
    @IBOutlet weak var SliderSize: UISlider!
    @IBOutlet weak var sliderWight: UISlider!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var wightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWightValue()
        updateSizeValue()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sliderSizeMoved(_ sender: UISlider) {
        updateSizeValue()
    }
    func updateSizeValue(){
        let sizeValue = String(format: "%.2f", ceil(self.SliderSize.value*100)/100)
        self.sizeLabel.text = sizeValue
    }
    @IBAction func sliderWightMoved(_ sender: UISlider) {
        updateWightValue()
    }
    func updateWightValue(){
        let wightValue = String(format: "%.2f", ceil(self.sliderWight.value*100)/100)
        self.wightLabel.text = wightValue
    }
    @IBAction func resultButton(_ sender: Any) {
        let result = self.sliderWight.value/(self.SliderSize.value)*(self.SliderSize.value)
        if result >= 16.00 && result < 18.50{
            showAlertsIMC(title: "Bajo peso", message: "Uy, creo que deveria comer mas....")
        }else if result > 18.5 && result <= 24.99 {
            showAlertsIMC(title: "Peso Normal", message: "Enhorabuena, usted tiene una buena condicion IMC")
        }else if result >= 25.00 && result <= 29.99{
            showAlertsIMC(title: "Sobre Peso", message: "Uy, creo que deverias cuidar tu alimentacion un poco.")
        }else{
            showAlertsIMC(title: "Obesidad", message: "Amig@ creo que deverias tomarlo encerio")
        }
    }
    func showAlertsIMC(title: String?, message: String?){
        //definition square of alert and title, message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //definition the button inside there
        let agreeBtn = UIAlertAction(title: "Acpetar", style: .default, handler: nil)
        alert.addAction(agreeBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
}
