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
    private var document: TextDocument?
    
    //MARK: - Initializer
    init(textViewer: TextViewer) {
        self.textViewer = textViewer
        
        textViewer.updateTitle(fileTitle: "Internship")
    }
    
    public func openDocument() {
        // Access the document
        document?.open(completionHandler: { [textViewer, document] (success) in
            if success {
                // Display the content of the document, e.g.:
                if let document =  document {
                    textViewer.updateTextView(text: document.text)
                }
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    public func createDocument(documentURL: URL) {
        document = TextDocument(fileURL: documentURL)
    }
    
    public func saveDocument() {
        document?.text = textViewer.getText()
        document?.updateChangeCount(.done)
    }
}
