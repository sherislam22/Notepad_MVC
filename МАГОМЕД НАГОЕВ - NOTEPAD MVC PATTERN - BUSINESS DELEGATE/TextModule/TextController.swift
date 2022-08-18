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
        print(textViewer.getFilename())
        careTaker = CareTaker(textWriter: textViewer)
        careTaker.save()
        openDocument()
        setTitle()
    }

    // MARK: public methods
    
    @objc func showMenu() {
        router.pushContentMenu(delegate: self)
    }
    
    func setTitle() {
        let name = fileManager.getFileName(urlPath: urlPath)
        textViewer.updateTitle(fileTitle: name)
    }
    
    func setUrl(urlPath: String) {
        self.urlPath = urlPath
    }
    
    @objc func save() {
        fileManager.saveFile(fileUrl: urlPath,
                             textFile: textViewer.getText(),
                             fileName: "Test1")
    }
    
   func saveAs() {
        let filename = textViewer.getFilename().split(separator: ".")
        let ext = filename.last
        print(ext ?? "", "file")
        let file = fileManager.saveAs(filename: String(filename[0]), content: textViewer.getText(), ext: String(ext ?? "ntp"))
        if file == "error" {
            
        }
    }
    
    
    // MARK: private methods
    private func openDocument() {
        textViewer.navigationController?.pushViewController(DocumentViewer(), animated: true)
        careTaker.states.removeAll()
        if urlPath != "" {
            let file = fileManager.openFile(fileNamePath: urlPath)
            textViewer.updateTextView(text: file)
        }
    }
}

extension TextController: MenuViewControllerDelegate {
    
    func menuViewController(didPressMenu menu: MenuOptions) {
        switch menu {
        case .new:
            router.initialViewController(urlPath: "")
        case .open:
            router.pushDocumentViewer()
        case .save:
            save()
        case .saveAs:
            textViewer.didTapSaveButton()
        case .print:
            print("Print")
        case .info:
            router.pushInformationViewController()
        }
    }
}
