//
//  SecondViewController.swift
//  03-coding
//
//  Created by Walter gomez on 2/4/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var fibonachi : [Int] = [0,1]
    var figId = 1
    var wantsGoldNum = false
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var textViewResult: UITextView!
    @IBOutlet weak var steeperNumber: UIStepper!
    @IBOutlet weak var labelGoldNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateSteeper(id : Int(self.steeperNumber.value))
    }
    func generateFibNumbers(){
        //skip steps
        if(figId<=1||figId>=100){
            return
        }
        //Create since 0 the sentence of fibonachi
        fibonachi = [0,1]
        
        for i in 2...figId {
            fibonachi.append(fibonachi[i-1]+fibonachi[i-2])
        }
        //$0 is the references for variable
        let fibstr : [String] = fibonachi.compactMap({String($0)})
        let result : String = fibstr.joined(separator: "\n")
        self.textViewResult.text = result
    }
    
    @IBAction func steeperPressed(_ sender: UIStepper) {
        updateSteeper(id: Int(sender.value))
    }
    func updateSteeper(id: Int){
        self.figId = id
        self.labelNumber.text = "\(self.figId)"
        generateFibNumbers()
        calulateGoldNum()
    }
    
    @IBAction func swichMove(_ sender: UISwitch) {
        self.wantsGoldNum = sender.isOn
        calulateGoldNum()
    }
    func calulateGoldNum(){
        if wantsGoldNum == true {
            //Hay que generar el numero de oro como cociente entre los dos ultimos numeros de fibonachi
            //We have to generate the gold number, how "cociente" between 2 last fibonachi numbers.
            let last = Double(self.fibonachi[fibonachi.count-1])
            let previuos = Double(self.fibonachi[fibonachi.count-2])
            let goldNum = last / previuos
            self.labelGoldNum.text = "\(goldNum)"
            
        }else{
            self.labelGoldNum.text = "Ver el Numero de oro"
        }
    }
}

