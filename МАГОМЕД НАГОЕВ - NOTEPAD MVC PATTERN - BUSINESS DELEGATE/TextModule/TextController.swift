//
//  TextController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 9/8/22.
//

import Foundation
import UIKit


class TextController {
    
    // MARK: Properties
    private var urlPath: String
    private let textViewer: TextViewer
    private let fileManager: FileManagerModel
    let router: RouterProtocol
    let careTaker: CareTaker
//    private let text: String
    
    //MARK: - Initializer
    init(textViewer: TextViewer,
         urlPath: String,
         router: RouterProtocol) {
        self.textViewer = textViewer
        self.fileManager = FileManagerModel()
        self.router = router
        self.urlPath = urlPath

        careTaker = CareTaker(textWriter: textViewer)
        careTaker.save()

        openDocument()
        setTitle()
    }

    // MARK: public methods
    
    func showMenu() {
        router.pushContentMenu(urlPath: urlPath, text: textViewer.getText())
    }
    
    func setTitle() {
        let name = fileManager.getFileName(urlPath: urlPath)
        textViewer.updateTitle(fileTitle: name)
    }
    
    func setUrl(urlPath: String) {
        self.urlPath = urlPath
    }
    
    // MARK: private methods
    private func openDocument() {
        
        careTaker.states.removeAll()
        
        if urlPath != "" {
            let file = fileManager.openFile(fileNamePath: urlPath)
            textViewer.updateTextView(text: file)
        }
    }
}
