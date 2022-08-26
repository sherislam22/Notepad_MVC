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
    let router: RouterProtocol
    let careTaker: CareTaker
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
        careTaker.states.removeAll()
        if let fileUrl = fileUrl {
            let text = fileManager.openFile(fileUrl)
            textViewer.updateTextView(text: text)
            textViewer.updateTitle(fileTitle: fileUrl.lastPathComponent)
        } else {
            textViewer.updateTitle(fileTitle: "Untitled")
        }
    }
}

extension TextController: MenuViewControllerDelegate {
    
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
            router.pushPrintViewer(text: textViewer.getText(), font: textViewer.getFont())
        case .info:
            router.pushInformationViewController()
        }
    }
}
