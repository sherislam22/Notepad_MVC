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
    func pushContentMenu(delegate: MenuViewControllerDelegate)
    func pushInformationViewController()
}

class Router: RouterProtocol {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.barStyle = .black
        self.navigationController.navigationBar.isTranslucent = false
        navigationController.showLaunchView()
    }
    
    func initialViewController() {
        let textViewer = TextViewer(router: self)

        navigationController.viewControllers = [textViewer]
    }
    
    func pushContentMenu(delegate: MenuViewControllerDelegate) {
        let menuViewer = MenuViewController(router: self)
        menuViewer.delegate = delegate
        navigationController.pushViewController(menuViewer, animated: true)
    }
    
    func pushInformationViewController() {
        let informationViewController = InformationViewController()
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func closeContentMenu() {
        navigationController.popToRootViewController(animated: true)
    }
}
