//
//  DrawingImageView.swift
//  07-MathTraning
//
//  Created by Walter gomez on 3/9/19.
//  Copyright © 2019 Renzo Gomez. All rights reserved.
//

import UIKit

class DrawingImageView: UIImageView {
    //Not Strong references, in this case its not necesary , beacuase that produce an error.
    weak var delegate :  ViewController?
    //Position at the moment of touch
    var currentTouchPoccision : CGPoint?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*G
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    func draw(from start: CGPoint, to end: CGPoint){
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        //ctx is the context
        self.image = renderer.image{ ctx in
            //draw into image view zone.
            self.image?.draw(in : self.bounds)
            //change the color
            UIColor.darkGray.setStroke()
            //change the parametres.
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setLineWidth(9)
            //draw a line from start to end
            ctx.cgContext.move(to: start)
            ctx.cgContext.addLine(to: end )
            ctx.cgContext.strokePath()
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //touch at the moment
        self.currentTouchPoccision = touches.first?.location(in: self)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        //if we can create a new point
        guard let newTouchPoint = touches.first?.location(in: self) else{
            return
        }
        guard let previousTouchPoint = self.currentTouchPoccision else{
            return
        }
        draw(from: previousTouchPoint, to: newTouchPoint)
        self.currentTouchPoccision = newTouchPoint
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        //reset currentTouchPossition.
        self.currentTouchPoccision = nil
        //wait sometime for complete the figure , if it is necessary
        perform(#selector(numberDrawOnScreen), with: nil, afterDelay: 0.5)
        
    }
    //send the draw done
    @objc func numberDrawOnScreen(){
        //validation of image
        guard let image = image else{
            return
        }
        let drawRect = CGRect(x: 0, y: 0, width: 28, height: 28)
        //Resize the object for match with images
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        //converter
        let renderer = UIGraphicsImageRenderer(bounds: drawRect, format: format)
        let imageWithWhiteBackground = renderer.image{ctx in
            UIColor.white.setFill()
            ctx.fill(bounds)
            image.draw(in: drawRect)
        }
        //coverted UIImage of CG at CI
        let ciImage = CIImage(cgImage: imageWithWhiteBackground.cgImage!)
        //background color converted tool by Core Image
        if let filter = CIFilter(name: "CIColorInvert"){
            //definition of an image to be filter.
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            //context of CI
            let context = CIContext(options: nil)
            
            if let outputImage = filter.outputImage{
                //try the creation  to CGImage.
                //ciImage.extent = real image
                if let imageRef = context.createCGImage(outputImage, from: ciImage.extent){
                    //convert this in a type of file what I can use for process of result
                    let resultImage = UIImage(cgImage: imageRef)
                    //finally I Pass the image at ViewController.
                    self.delegate?.numberDrown(resultImage)
                }
            }
        }
    }
}
