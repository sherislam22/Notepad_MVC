//
//  TextController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 9/8/22.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

class TextController: NSObject {
    
    // MARK: Properties
    private var url: String
    private let textViewer: TextViewer
    private var document: TextDocument?
    private let fileManager: FileManagerModel
    let router: RouterProtocol
    let careTaker: CareTaker
    
    //MARK: - Initializer
    init(textViewer: TextViewer,
         router: RouterProtocol) {
        self.textViewer = textViewer
        self.fileManager = FileManagerModel()
        self.router = router
        url = ""
        textViewer.updateTitle(fileTitle: "Internship")
        careTaker = CareTaker(textWriter: textViewer)
        careTaker.save()
    }

    // MARK: public methods
    @objc public func new() {
        if let document = document {
            document.close { success in
                self.document = nil
                self.textViewer.updateTextView(text: "")
            }
        } else {
            textViewer.updateTextView(text: "")
        }

        textViewer.navigationController?.popToRootViewController(animated: true)

    }
    
    @objc public func open() {
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: [UTType(filenameExtension: "ntp")!,
            UTType(filenameExtension: "kt")!,
            UTType(filenameExtension: "java")!,
            UTType(filenameExtension: "text")!,
            .swiftSource])
        
        pickerViewController.delegate = self

        textViewer.present(pickerViewController, animated: true)
    }
    
    @objc public func save() {
        print(self.url,"url")
        fileManager.saveFile(fileUrl: self.url, textFile: textViewer.getText())
    }
    
    @objc public func saveAs() {
        let url = fileManager.saveAs(filename: document?.localizedName ?? "default", content: textViewer.getText(), ext: "ntp")
        let pickerViewController = UIDocumentPickerViewController(
            forExporting: [url], asCopy: false)
        pickerViewController.delegate = self
        textViewer.present(pickerViewController, animated: true)
    }
    
    func showMenu() {
        router.pushContentMenu(delegate: self )
    }
    
    // MARK: private methods
    private func openDocument() {
        let file = fileManager.openFile(fileNamePath: self.url)
        textViewer.updateTextView(text: file)
    }
}

// MARK: - UIDocumentPickerDelegate
extension TextController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        self.url = ""
        self.url = url.path
        print(self.url)
        openDocument()
        textViewer.getUrl(url: url)
    }
}

// MARK: - MenuViewControllerDelegate
extension TextController: MenuViewControllerDelegate {
    
    func menuViewController(didPressMenu menu: MenuOptions) {
        switch menu {
        case .new:
            new()
        case .open:
            open()
        case .save:
            save()

        case .saveAs:
            saveAs()
        case .print:
            print("Print")
        case .info:
            router.pushInformationViewController()
        }
    }
}
  


