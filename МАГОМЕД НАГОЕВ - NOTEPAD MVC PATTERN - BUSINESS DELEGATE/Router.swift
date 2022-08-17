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
    func pushContentMenu(urlPath: String,
                         text: String)
    func pushInformationViewController()
    func pushDocumentViewer()
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
        textViewer.textController = textController

        navigationController.viewControllers = [textViewer]
    }
    
    func pushDocumentViewer() {
        let documentViewer = DocumentViewer()
        let documentController = DocumentController(documentViewer: documentViewer,
                                                    router: self)
        documentViewer.documentController = documentController
        
        navigationController.pushViewController(documentViewer, animated: true)
    }
    
    func pushContentMenu(urlPath: String,
                         text: String) {

        let menuViewer = MenuViewer()
        let menuController = MenuController(menuViewer: menuViewer,
                                            router: self,
                                            urlPath: urlPath,
                                            text: text)

        menuViewer.menuController = menuController
        
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
}
