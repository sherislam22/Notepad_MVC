//
//  PrintController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 21/8/22.
//


import UIKit

class PrintController {
    let text: String
    let printModel: PrintModel
    
    init(printViewer: PrintViewer,
         text: String) {
        self.text = text
        printModel = PrintModel(printViewer: printViewer)
    }
    
    func callPrint(text: String) {
        printModel.createImage(text: text)
    }
}
