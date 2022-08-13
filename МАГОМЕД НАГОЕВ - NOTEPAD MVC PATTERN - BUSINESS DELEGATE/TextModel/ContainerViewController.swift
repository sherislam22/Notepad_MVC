//
//  ContainerViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by begaiym akunova on 13/8/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let tectViewerVC = TextViewer()
    var navVC: UINavigationController?
    lazy var infoVC = InformationViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        addChildVC()
    }
    
    private func addChildVC() {
        //menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        //home
        tectViewerVC.delegate = self
        let navVC = UINavigationController(rootViewController: tectViewerVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

extension ContainerViewController: TextViewerDelegate {
    func menuButtonTapped() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.tectViewerVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        //print("did select func")
        toggleMenu(completion: nil)
        switch menuItem {
        case .new:
            break
        case .open:
            break
        case .save:
            break
        case .saveAs:
            break
        case .print:
            break
        case .info:
            self.infoButtonTapped()
        }
    }
    
    func infoButtonTapped() {
        let vc = infoVC
        tectViewerVC.addChild(vc)
        tectViewerVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: tectViewerVC)
        tectViewerVC.title = vc.title
    }

}
