////
////  TabBarController.swift
////  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
////
////  Created by Нагоев Магомед on 7/8/22.
////
//
//import UIKit
//
//class TabBarController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureTabBar()
//        configureViewControllers()
//    }
//
//    func configureTabBar() {
//        tabBar.backgroundColor = .white
//    }
//
//    func configureViewControllers() {
//        let mainViewController  = MainViewController()
//        let mainNavigationController = templateNavigationController(image: UIImage(systemName: "folder")!,
//                                                    tabBarItemTitle: "Обзор",
//                                                    rootViewController: mainViewController)
//
//        let informationViewController = InformationViewController()
//        let informationNavigationController = templateNavigationController(image: UIImage(systemName: "info")!,
//                                                       tabBarItemTitle: "Информация",
//                                                       rootViewController: informationViewController)
//
//        viewControllers = [mainNavigationController,
//                           informationNavigationController]
//    }
//
//    func templateNavigationController(image: UIImage,
//                                      tabBarItemTitle: String,
//                                      rootViewController: UIViewController) -> UINavigationController {
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.tabBarItem.image = image
//        navigationController.navigationBar.isTranslucent = false
//        navigationController.view.backgroundColor = .white
//        navigationController.tabBarItem.title = tabBarItemTitle
//        return navigationController
//    }
//
//}
