//
//  ViewController.swift
//  01-IAmRich
//
//  Created by Walter gomez on 12/18/18.
//  Copyright © 2018 Walter gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//Prototipos
    
    @IBOutlet weak var labelTItle: UILabel!
    
    @IBOutlet weak var imageViewDiamond: UIImageView!
    
    @IBOutlet weak var buttonPush: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Imprecion en consola, es muy parecida a Pyhton.....
        print("Hola que tal")
    }
    //Methods
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        /*//Cambie el texto del label
        self.labelTItle.text = "the button has push"
        //cambia el color del label
        self.labelTItle.textColor = UIColor.black
        //Cambiar la fuente de una etiqueta
        self.labelTItle.font = UIFont.boldSystemFont(ofSize: 24.0)
        //cambiar la imagen
        self.imageViewDiamond.image = UIImage(named:"realDiamond")*/
        
        //Creacion de un mensaje(Alert)
        let controller = UIAlertController(title: "I'm Rich", message: """
I'm rich,
I deserve it,
I am good,
healthy and succesfull
""", preferredStyle: .alert)
        let action0 = UIAlertAction(title: "Aceptar", style: .default) { (action0) in
            print("he pulsado el boton aceptar")
        }
        controller.addAction(action0)
        
        let action1 = UIAlertAction(title: "Borrar", style: .destructive, handler:{(action1) in
            print("He pulsado el bonton de borrar")
        })
        controller.addAction(action1)
        
        let action2 = UIAlertAction(title: "Cancelar", style: .cancel, handler:{(action2) in
            print("He pulsado el boton de cancelar")
        })
        controller.addAction(action2)
        
        show(controller, sender: nil)
        
    }
}

