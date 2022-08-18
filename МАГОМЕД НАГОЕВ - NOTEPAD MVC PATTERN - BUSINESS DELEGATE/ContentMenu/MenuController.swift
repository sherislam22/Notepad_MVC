////
////  MenuController.swift
////  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
////
////  Created by Нагоев Магомед on 17/8/22.
////
//
//import Foundation
//
//class MenuController {
//    private let menuViewer: MenuViewer
//    let router: RouterProtocol
//    let urlPath: String
//    let fileManager: FileManagerModel
//    let text: String
//
//    init(menuViewer: MenuViewer,
//         router: RouterProtocol,
//         urlPath: String,
//         text: String) {
//        self.menuViewer = menuViewer
//        self.router = router
//        self.urlPath = urlPath
//        fileManager = FileManagerModel()
//        self.text = text
//    }
//    
//    func save() {
//        fileManager.saveFile(fileUrl: urlPath,
//                             textFile: text,
//                             fileName: "Test1")
//    }
//    
//    
//
//}
