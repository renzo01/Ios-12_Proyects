//
//  FontDetailViewController.swift
//  03-coding
//
//  Created by Walter gomez on 2/11/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit

class FontDetailViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var familyName : String = ""
    var fonts : [String] = []
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var pickerFonts: UIPickerView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.labelTitle.text = familyName
        self.labelTitle.font = UIFont(name: familyName, size: 25.0)
        if self.fonts.count == 0{
            self.pickerFonts.isHidden = true
        }else{
            //link with self ViewController.
            self.pickerFonts.dataSource = self
            self.pickerFonts.delegate = self
        }
        self.textView.font = UIFont(name: familyName, size: 14.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        //close this UX
        self.dismiss(animated: true)
    }
    // MARK: -UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.fonts.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    // Mark: -UIPikcer Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let font = self.fonts[row]
        self.textView.font = UIFont(name: font, size: 14.0)
    }
}
