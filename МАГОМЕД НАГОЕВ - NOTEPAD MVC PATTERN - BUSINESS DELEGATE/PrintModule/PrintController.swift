//
//  PrintController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 21/8/22.
//


import UIKit

class PrintController {
    let text: String
    let font: UIFont
    let printModel: PrintModel
    
    init(printViewer: PrintViewer,
         text: String, font: UIFont) {
        self.text = text
        self.font = font
        printModel = PrintModel(printViewer: printViewer)
       
    }
    
    func callPrint(text: String, font: UIFont) {
        printModel.createImage(text: text)
    }
}
