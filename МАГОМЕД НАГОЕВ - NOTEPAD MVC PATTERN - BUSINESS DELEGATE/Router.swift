//
//  Router.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 14/8/22.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func initialViewController(urlPath: String)
    func pushContentMenu(delegate: MenuViewControllerDelegate)
    func pushInformationViewController()
    func pushDocumentViewer()
    func pushPrintViewer(text: String, font: UIFont)
}

class Router: RouterProtocol {
    
    

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.barStyle = .black
        self.navigationController.navigationBar.isTranslucent = false
        navigationController.showLaunchView()
    }
    
    func initialViewController(urlPath: String) {
        let textViewer = TextViewer()
        let textController = TextController(textViewer: textViewer,
                                            urlPath: urlPath,
                                            router: self)
        textViewer.setTextController(textController)

        navigationController.viewControllers = [textViewer]
    }
    
    
    
    func pushDocumentViewer() {
        let documentViewer = DocumentViewer()
        let documentController = DocumentController(documentViewer: documentViewer,
                                                    router: self)
        documentViewer.setDocumentController(documentController)
//        documentViewer.documentController = documentController
        
        navigationController.pushViewController(documentViewer, animated: true)
    }
    
    func pushContentMenu(delegate: MenuViewControllerDelegate) {

        let menuViewer = MenuViewer()
        menuViewer.setDelegate(delegate)
//        menuViewer.delegate = delegate
        navigationController.pushViewController(menuViewer,
                                                animated: true)
    }
    
    func pushInformationViewController() {
        let informationViewController = InformationViewController()
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func closeContentMenu() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func pushPrintViewer(text: String, font: UIFont) {
        let printViewer = PrintViewer(text: text, font: font)
        printViewer.presentPrintInteractionController()
        
    }
}
