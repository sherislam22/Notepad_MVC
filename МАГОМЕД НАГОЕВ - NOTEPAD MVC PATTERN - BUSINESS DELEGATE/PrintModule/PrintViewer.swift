//
//  PrintViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 21/8/22.
//

import UIKit

class PrintViewer {
    var printController: PrintController?
    var printInteractionController: UIPrintInteractionController
    
    init(text: String, font: UIFont) {
        printInteractionController = UIPrintInteractionController.shared
        printController = PrintController(printViewer: self, text: text, font: font)
        printController?.callPrint(text: text, font: font)
    }

    func setImage(image: [UIImage]) {
        
        let printInfo = UIPrintInfo(dictionary: nil)
        
        printInfo.jobName = "printing an image"
        printInfo.outputType = .general
        
        printInteractionController.printInfo = printInfo
        
        printInteractionController.printingItems = image
    }
}
