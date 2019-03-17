//
//  ViewController.swift
//  02-dices
//
//  Created by Walter gomez on 12/19/18.
//  Copyright © 2018 Walter gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewDiceRight: UIImageView!
    
    @IBOutlet weak var imageViewDiceLeft: UIImageView!
    
    var randomDiceIndexLeft : Int = 0
    
    var randomDiceIndexRight : Int = 0
    //tipo de array
    let diceImages : [String]
    let nFaces : UInt32
    required init?(coder aDecoder: NSCoder) {
        diceImages = ["diceFace1","diceFace2","diceFace3","diceFace4","diceFace5","diceFace6"]
        nFaces = UInt32(diceImages.count)
        super.init(coder : aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func rollPressed(_ sender: Any) {
        generateRamdonDices()
    }
    
    func generateRamdonDices() {
        //genera y cambia aleatoriamente la posicion del dado izquierdo.
        randomDiceIndexLeft =  Int (arc4random_uniform(nFaces))
        //genera y cambia aleatoriamente la posicion del dado derecho.
        randomDiceIndexRight = Int (arc4random_uniform(nFaces))
        imageViewDiceLeft.image = UIImage(named: diceImages[randomDiceIndexLeft])
        imageViewDiceRight.image = UIImage(named: diceImages[randomDiceIndexRight])
        //Metodo necesario para indicar que se trata de una animacion.
        UIView.animate(withDuration: 0.5, delay: 0, options:   UIView.AnimationOptions.curveEaseOut, animations: {
            //para animaciones tipicas se tiene
            //las animaciones tambien se pueden concatenar
            self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(translationX: 0, y: 100)).concatenating(CGAffineTransform(rotationAngle: 2*CGFloat.pi/2))
            self.imageViewDiceRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(translationX: 0, y: 100)).concatenating(CGAffineTransform(rotationAngle: 2*CGFloat.pi/2))
            //permite cambiar la visivilidad de la imagen, este caso la hacemos invisible.
            self.imageViewDiceLeft.alpha = 0.0
            self.imageViewDiceRight.alpha = 0.0
            /*self.imageViewDiceLeft.transform = CGAffineTransform(translationX: 0, y: 10)
            self.imageViewDiceLeft.transform = CGAffineTransform(rotationAngle: 2*CGFloat.pi)*/
            
            //accion que se tomara al completar la animacion.
        }) { (completed) in
            //permite devolver al estado original las propiedades conserninte con la animacion de la imagen.
            self.imageViewDiceLeft.transform = CGAffineTransform.identity
            self.imageViewDiceRight.transform = CGAffineTransform.identity
            //permite devolver la visibilidad a la imagen.
            self.imageViewDiceLeft.alpha = 1.0
            self.imageViewDiceRight.alpha = 1.0
            //simpre se tiene que hacer referencia al objeto global ya que este es un metodo que esta en un espacio de memoria diferente.
            self.imageViewDiceRight.image = UIImage(named : self.diceImages[self.randomDiceIndexRight])
            self.imageViewDiceLeft.image = UIImage(named : self.diceImages[self.randomDiceIndexLeft])
        }
    }
    //Para usar la funcion de scacudadida en los dispositivos tenemos que sobreescrivir la funcion "becomeFirstResponder"
    override func becomeFirstResponder() -> Bool {
        //se tiene que devolver un valor booleano
        return true
    }
    //hay funciones de movimiento que pueden ser sobreescritas al comenzar, finalizar o cancelar el moviminiento.
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            generateRamdonDices()
        }
    }
    
}

