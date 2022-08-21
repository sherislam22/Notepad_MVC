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

    }
    
}
