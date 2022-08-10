//
//  TextController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 9/8/22.
//

import Foundation

class TextController {
    
    //MARK: - Properties
    private let textViewer: TextViewer
    
    //MARK: - Initializer
    init(textViewer: TextViewer) {
        self.textViewer = textViewer
        
        textViewer.updateTitle(fileTitle: "Internship")
    }
    
}
