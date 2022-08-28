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
    private var fileUrl: URL?
    
    let textViewer: TextViewer
    private let fileManager: FileManagerModel
    private let router: RouterProtocol
    private let careTaker: CareTaker
//    private let text: String
    
    //MARK: - Initializer
    init(textViewer: TextViewer,
         fileUrl: URL?,
         router: RouterProtocol) {
        self.textViewer = textViewer
        self.fileManager = FileManagerModel()
        self.router = router
        self.fileUrl = fileUrl
        careTaker = CareTaker(textWriter: textViewer)
        careTaker.save()
        openDocument()
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
    
    @objc func showMenu(barButtonItem: UIBarButtonItem) {
        router.showContentMenu(over: barButtonItem, delegate: self)
    }
    
    func save() {
        if let fileUrl = fileUrl {
            fileManager.save(fileUrl: fileUrl, content: self.textViewer.getText())
        } else {
            saveAs()
        }
    }
    
   func saveAs() {
       let alert = UIAlertController.createGetFileNameAlert(completion: { alertController, fileName in
           let fileUrl = self.fileManager.generateFileUrl(fileName: fileName)
           
           let performReplace = {
               self.fileManager.save(fileUrl: fileUrl, content: self.textViewer.getText())
               self.fileUrl = fileUrl
               self.textViewer.updateTitle(fileTitle: fileUrl.lastPathComponent)
           }
           
           if self.fileManager.fileExists(fileUrl) {
               let renameReplaceAlert = UIAlertController.createRenameOrOverwriteAlert(
                onRename: {
                    self.textViewer.present(alertController, animated: true)
                },
                onReplace: {
                    performReplace()
                })
               self.textViewer.present(renameReplaceAlert, animated: true)
           } else {
               performReplace()
           }
       })
       textViewer.present(alert, animated: true)
       
       
    }
   
    func openAnotherDocument() {
        router.pushDocumentViewer()
    }
    
    // MARK: private methods
    private func openDocument() {
        textViewer.navigationController?.pushViewController(DocumentViewer(), animated: true)
        var states = careTaker.getStates()
        states.removeAll()
        if let fileUrl = fileUrl {
            let text = fileManager.openFile(fileUrl)
//            let text = fileManager.readFileByCharacter(fileUrl)  // для чтение по символам закоментируйте верхнюю линию и расскоментируйте данную
            textViewer.updateTextView(text: text)
            textViewer.updateTitle(fileTitle: fileUrl.lastPathComponent)
        } else {
            textViewer.updateTitle(fileTitle: "Untitled")
        }
    }
}

extension TextController: MenuViewControllerDelegate {
    
    func printText() {
        let alert = UIAlertController.callStandartAlert(title: "Warning.",
                                                        message: "You can't print empty page!")
        if textViewer.getText().isEmpty {
            textViewer.presentAlert(alert: alert)
        } else {
            router.pushPrintViewer(text: textViewer.getText(), font: textViewer.getFont())
        }
    }
    
    func menuViewController(didPressMenu menu: MenuOptions) {
        switch menu {
        case .new:
            router.initialViewController(fileUrl: nil)
        case .open:
            router.pushDocumentViewer()
        case .save:
            save()
        case .saveAs:
            saveAs()
        case .print:
            printText()
        case .info:
            router.pushInformationViewController()
        }
    }
}
