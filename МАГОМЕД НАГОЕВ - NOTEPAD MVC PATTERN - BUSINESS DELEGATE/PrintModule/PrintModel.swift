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
    private let printViewer: PrintViewer
    private var images: [UIImage]
    
    init(printViewer: PrintViewer) {
        self.printViewer = printViewer
        images = []
    }
    
    func createImage(text: String,
                     font: UIFont) {
    
        let frame = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        var textPos = 0
        
        let attributes = [NSAttributedString.Key.font: font]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        

        let render = UIGraphicsImageRenderer(size: frame.size)

        while textPos < attrString.length {
            let framesetter = CTFramesetterCreateWithAttributedString(attrString)
            
            
            let textFrame = frame.insetBy(dx: 10, dy: 20)
            let numberFrame = CGRect(x: frame.width - 60, y: frame.height - 20, width: 60, height: 20)
            
            let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.right

            NSString(string: "\(images.count + 1)").draw(in: numberFrame, withAttributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
            let path = CGMutablePath()
            path.addRect(textFrame)
            
            let ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, nil)
            
            let linesCFArray: NSArray = CTFrameGetLines(ctframe)
            let lines = linesCFArray as Array
            
            let image = render.image { renderContext in
                renderContext.cgContext.translateBy(x: 0, y: frame.size.height)
                renderContext.cgContext.scaleBy(x: 1.0, y: -1.0)

                var index = CFIndex(0)
                for line in lines {
                    var lineOrigin: CGPoint = CGPoint.zero
                    CTFrameGetLineOrigins(ctframe, CFRangeMake(index, 1), &lineOrigin)
                    
                    renderContext.cgContext.textPosition = .init(x: lineOrigin.x + 10, y: lineOrigin.y + 20)
                    let ctline = line as! CTLine
                    // это у нас drawString()
                        CTLineDraw(ctline, renderContext.cgContext)
                    index += 1
                }
                
            }

            let frameRange = CTFrameGetVisibleStringRange(ctframe)
            textPos += frameRange.length
         
            images.append(image)
        }
        
        printViewer.setImage(image: images)
    }
    
    
}
