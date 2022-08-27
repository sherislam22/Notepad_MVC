//
//  MenuViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by begaiym akunova on 13/8/22.
//

import UIKit



protocol MenuViewControllerDelegate: AnyObject {
    func menuViewController(didPressMenu menu: MenuOptions)
}


class MenuViewer: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: UITableView
    weak var delegate: MenuViewControllerDelegate?
    
    init() {
        tableView = UITableView()
    
        super.init(nibName: nil, bundle: nil)

        tableView.backgroundColor = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.preferredContentSize = CGSize(
            width: UIScreen.main.bounds.width * 0.6,
            height: CGFloat(MenuOptions.allCases.count) * 44)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .gray
        tableView.rowHeight = 44
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)

    }
    
    func setDelegate(_ delegate: MenuViewControllerDelegate) {
        self.delegate = delegate
    }

    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = .gray
        cell.contentView.backgroundColor = nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        presentingViewController?.dismiss(animated: true, completion: {
            self.delegate?.menuViewController(didPressMenu: item)
        })
    }
}
