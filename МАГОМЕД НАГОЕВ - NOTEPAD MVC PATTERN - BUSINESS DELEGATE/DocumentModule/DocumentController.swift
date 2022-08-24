//
//  DocumentController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 17/8/22.
//

import UIKit

class DocumentController {
    private let documentViewer: DocumentViewer
    private let fileManager: FileManagerModel
    private var pathDictionary: [String: String]
    private let router: RouterProtocol
    
    init(documentViewer: DocumentViewer,
         router: RouterProtocol) {
        self.documentViewer = documentViewer
        fileManager = FileManagerModel()
        pathDictionary = fileManager.getPaths()
        self.router = router
    }
    
    func getCountUrls() -> Int {
        return pathDictionary.count
    }
    
    func getPath(index: Int) -> String {
        let pathArray = pathDictionary.map {$0.key}
        return pathArray[index]
    }
    
    func getFileName(index: Int) -> String {
        let nameList = pathDictionary.map {$0.value}
        return nameList[index]
    }
    
    func setTextForTextViewer(path: String) {
        guard let fileSize = fileManager.getFileSize(at: path) else { return }
        if fileSize > 5_629_273 {
            let alert = UIAlertController.createFileMaxSizeErrorAlert()
            documentViewer.present(alert, animated: true)
        } else {
            router.initialViewController(urlPath: path)
        }
    }
    
    func getpathExt(path: String) -> String {
        let ext = fileManager.getPathExt(urlPath: path)
        return ext
    }
}
