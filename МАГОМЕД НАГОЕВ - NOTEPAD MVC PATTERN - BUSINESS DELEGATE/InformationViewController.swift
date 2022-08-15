//
//  InformationViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var mainTableView = UITableView()
    //var mainTableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    let identifer = "TableViewCell"
    
    
    private var developer = ["Бекболсун Таалайбеков", "Акунова Бегайым", "Наргиза Бейшекенова", "Памирбек Алмазбеков", "Шерислам Талатбеков", "Бексултан Маратов", "Магомед Нагоев",]
    
    //MARK: --------------------------------------------override--------------------------------------
        override func viewDidLoad() {
        super.viewDidLoad()
        title = "InformationViewController"
        view.backgroundColor = .yellow
    }
}
