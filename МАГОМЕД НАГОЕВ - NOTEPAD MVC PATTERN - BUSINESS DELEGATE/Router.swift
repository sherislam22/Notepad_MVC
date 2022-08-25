//
//  Router.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 14/8/22.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func initialViewController(fileUrl: URL?)
    func showContentMenu(over barButtonItem: UIBarButtonItem, delegate: MenuViewControllerDelegate)
    func pushInformationViewController()
    func pushDocumentViewer()
    func pushPrintViewer(text: String, font: UIFont)
}

class Router: NSObject, RouterProtocol {
    
    

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.barStyle = .black
        self.navigationController.navigationBar.isTranslucent = false
        navigationController.showLaunchView()
    }
    
    func initialViewController(fileUrl: URL?) {
        let textViewer = TextViewer()
        let textController = TextController(textViewer: textViewer,
                                            fileUrl: fileUrl,
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
    
    func showContentMenu(over barButtonItem: UIBarButtonItem, delegate: MenuViewControllerDelegate) {

        let menuViewer = MenuViewer()
//<<<<<<< HEAD
        menuViewer.setDelegate(delegate)
////        menuViewer.delegate = delegate
//        navigationController.pushViewController(menuViewer,
//=======
//        menuViewer.delegate = delegate
        menuViewer.modalPresentationStyle = .popover
        let popoverPresentationController = menuViewer.popoverPresentationController
        popoverPresentationController?.barButtonItem = barButtonItem
        popoverPresentationController?.delegate = self
        navigationController.present(menuViewer,
//>>>>>>> origin/dev
                                                animated: true)
    }
    
    func pushInformationViewController() {
        let informationViewController = InformationViewController()
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func pushPrintViewer(text: String, font: UIFont) {
        let printViewer = PrintViewer(text: text, font: font)
        printViewer.presentPrintInteractionController()
        
    }
}

extension Router: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
