//
//  PrintViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 21/8/22.
//

import UIKit

final class PrintViewer {
    //MARK: - Properties
    private var printController: PrintController?
    private var printInteractionController: UIPrintInteractionController
    
    //MARK: - Initialize
    init(text: String, font: UIFont) {
        printInteractionController = UIPrintInteractionController.shared
        printController = PrintController(printViewer: self, text: text, font: font)
        printController?.callPrint(text: text, font: font)
    }
    
    //MARK: - Methods
    func presentPrintInteractionController() {
        printInteractionController.present(animated: true)
    }

    func launchPrint(image: [UIImage]) {
        
        let printInfo = UIPrintInfo(dictionary: nil)
        
        printInfo.jobName = "printing an image"
        printInfo.outputType = .general
        
        printInteractionController.printInfo = printInfo
        
        printInteractionController.printingItems = image
    }
}
