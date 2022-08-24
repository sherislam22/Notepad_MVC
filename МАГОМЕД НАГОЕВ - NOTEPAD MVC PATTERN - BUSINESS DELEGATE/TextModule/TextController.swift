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
    let textViewer: TextViewer
    private let fileManager: FileManagerModel
    private let router: RouterProtocol
    private let careTaker: CareTaker
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
    
    func undoDidTap() {
        careTaker.undo()
    }
    
    func redoDidTap() {
        careTaker.redo()
    }
    
    func careTakerSave() {
        careTaker.save()
    }
    
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
        var ext = filename.last
       if filename.count == 1 {
           ext = "ntp"
       }
        let file = fileManager.saveAs(filename: String(filename[0]), content: textViewer.getText(), ext: String(ext ?? "ntp"))
        if file == "error" {
        }
    }
   
    func openAnotherDocument() {
        router.pushDocumentViewer()
    }
    
    // MARK: private methods
    private func openDocument() {
        textViewer.navigationController?.pushViewController(DocumentViewer(), animated: true)
        var states = careTaker.getStates()
        states.removeAll()
//        careTaker.states.removeAll()
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
            router.pushPrintViewer(text: textViewer.getText(), font: textViewer.getFont())
        case .info:
            router.pushInformationViewController()
        }
    }
}
