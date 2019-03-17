//
//  ThirdController.swift
//  03-coding
//
//  Created by Walter gomez on 2/4/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit

class ThirdController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var families : [String] = []
    //use Dicctionari in swift
    var fonts : [String : [String]] = [:]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show the fonts , serted form
        self.families = UIFont.familyNames.sorted(by: {return $1 > $0})
        for fam in families {
            //put in this diccionari
            fonts[fam] = UIFont.fontNames(forFamilyName: fam)
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //created by Xcode
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFontsForFamilies"{
            let navController  = segue.destination as! UINavigationController
            let destinationViewController = navController.topViewController as! FontDetailViewController
            let idx = self.tableView.indexPathForSelectedRow!.row
            
            destinationViewController.familyName = self.families[idx]
            destinationViewController.fonts  = self.fonts[self.families[idx]]!
        }
    }
    
    
    //MARK: Methods created by Xcode for UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //Number of sectiion in the aplication.
        return 1
    }
    //interac with the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //quantity of elementes whats show on the cells
        return self.families.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Use again the cell, it works of this form for save memory ram
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "fontFamilyCell", for: indexPath)
        let fontFamily = families[indexPath.row]
        cell.textLabel?.text = fontFamily
        cell.textLabel?.font = UIFont(name: fontFamily, size: 20.0)
        return cell
    }
    //Mark: Methods of UITableViewDelegate protocol
    //select a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //save the row
        let row = indexPath.row
        let fontFamilies = families[row]
        //this diccionari never null
        let familyFonts = fonts[fontFamilies]!
        
        print(fontFamilies)
        print(familyFonts)
    }
}
