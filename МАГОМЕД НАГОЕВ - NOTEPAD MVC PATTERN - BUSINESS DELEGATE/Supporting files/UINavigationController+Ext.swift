//
//  UINavigationController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 13/8/22.
//

import Foundation
import UIKit


extension UINavigationController {
    
    func showLaunchView() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: view.bounds.width,
                           height: view.bounds.height)

        let launchView = LaunchView(frame: frame)
        view.addSubview(launchView)
    }
}
