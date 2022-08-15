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
    private let textViewer: TextViewer
    private var document: TextDocument?
    private let fileManager: FileManagerModel
    
    // MARK: Initializer
    init(textViewer: TextViewer) {
        self.fileManager = FileManagerModel()
        self.textViewer = textViewer
        
        textViewer.updateTitle(fileTitle: "Internship")
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
        if let textDocument = document {
            textDocument.save(to: textDocument.fileURL, for: .forOverwriting)
        } else {
            let url = fileManager.createFile(filename: "default", content: textViewer.getText(), ext: "ntp")
            let pickerViewController = UIDocumentPickerViewController(
                forExporting: [url], asCopy: false)
            pickerViewController.delegate = self
            textViewer.present(pickerViewController, animated: true)
        }
    }
    
    @objc public func saveAs() {
        let url = fileManager.createFile(filename: document?.localizedName ?? "default", content: textViewer.getText(), ext: "ntp")
        let pickerViewController = UIDocumentPickerViewController(
            forExporting: [url], asCopy: false)
        pickerViewController.delegate = self
        textViewer.present(pickerViewController, animated: true)
    }
    
    // MARK: private methods
    private func openDocument() {
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
}

// MARK: - UIDocumentPickerDelegate
extension TextController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        
        if let document = document { // если есть открытый документ, мы его закрываем
            document.close { success in
                self.document = TextDocument(fileURL: url)
                self.openDocument()
            }
        } else {
            document = TextDocument(fileURL: url)
            openDocument()
        }
    }
}


