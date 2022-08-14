//
//  Router.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 14/8/22.
//

import Foundation
import UIKit

protocol RouterProtocol {
    func initialViewController()
    func pushContentMenu()
    func pusInformationViewController()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialViewController() {
        let textViewer = TextViewer(router: self)

        navigationController.viewControllers = [textViewer]
    }
    
    func pushContentMenu() {
        let menuViewer = MenuViewController(router: self)
        navigationController.pushViewController(menuViewer, animated: true)
    }
    
    func pusInformationViewController() {
        let informationViewController = InformationViewController()
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func closeContentMenu() {
        navigationController.popToRootViewController(animated: true)
    }
}
