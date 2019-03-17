//
//  Extencions.swift
//  06-WebScrapping
//
//  Created by Walter gomez on 3/5/19.
//  Copyright © 2019 Walter gomez. All rights reserved.
//

import UIKit

extension UIImageView {
    //for download the images.
    func downloadedFrom(link : String, contentMode : UIView.ContentMode = .scaleAspectFit){
        //guard try to make a variable
        guard let url = URL(string: link) else {return}
        downloadedFrom(url: url)
    }
    //make logic
    func downloadedFrom(url : URL, contentMode mode : UIView.ContentMode = .scaleAspectFit){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else{return}
            DispatchQueue.main.async (){
                self.image = image
            }
            //.resume() active URLSession.
        }.resume()
    }
}
