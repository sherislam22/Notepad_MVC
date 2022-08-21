//
//  PrintModel.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 21/8/22.
//

import Foundation
import Foundation
import UIKit

class PrintModel {
    let printViewer: PrintViewer
    var images: [UIImage]
    
    init(printViewer: PrintViewer) {
        self.printViewer = printViewer
        images = []
    }
    
    func createImage(text: String) {
        let frame = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        var textPos = 0
        
        let myfont = CTFontCreateWithName("AvenirNext-bold" as CFString, 64, nil)
        let attributes = [NSAttributedString.Key.font: myfont]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        

        let render = UIGraphicsImageRenderer(size: frame.size)
        print(render.format.bounds)
        while textPos < attrString.length {
            let framesetter = CTFramesetterCreateWithAttributedString(attrString)
            
            let path = CGMutablePath()
            path.addRect(CGRect(origin: .zero, size: frame.size))
            
            let ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, nil)
            
            let image = render.image { renderContext in
                renderContext.cgContext.translateBy(x: 0, y: frame.size.height)
                renderContext.cgContext.scaleBy(x: 1.0, y: -1.0)
                
                CTFrameDraw(ctframe, renderContext.cgContext)
            }
            
            
            let frameRange = CTFrameGetVisibleStringRange(ctframe)
            textPos += frameRange.length
         
            images.append(image)
        }
        
        printViewer.setImage(image: images)
    }
    
    
}
