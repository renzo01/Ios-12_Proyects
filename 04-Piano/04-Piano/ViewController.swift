//
//  ViewController.swift
//  04-Piano
//
//  Created by Walter gomez on 2/13/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    let soundsArray = ["c1","c1s","d1","d1s","e1","f1","f1s","g1","g1s","a1","a1s","b1","c2"]
    var audioPlayer : AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func playSound(_ sender: UIButton) {
        let idKey = sender.tag
        let fileName = self.soundsArray[idKey-1]
        print("Hemos probado la tecla \(fileName)")
        //Create a URL
        if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
            print (soundURL)
            //Validation
            do{
                //call AVAudioPlayer
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            }catch{
                print(error)
            }
            audioPlayer.play()
        }
        
    }
}

