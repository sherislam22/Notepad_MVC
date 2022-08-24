//
//  PrintController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 21/8/22.
//


import UIKit

class PrintController {
    private let text: String
    private let font: UIFont
    private let printModel: PrintModel
    
    init(printViewer: PrintViewer,
         text: String, font: UIFont) {
        self.text = text
        self.font = font
        printModel = PrintModel(printViewer: printViewer)
       
    }
    
    func callPrint(text: String, font: UIFont) {
        printModel.createImage(text: text, font: font)
    }
}
