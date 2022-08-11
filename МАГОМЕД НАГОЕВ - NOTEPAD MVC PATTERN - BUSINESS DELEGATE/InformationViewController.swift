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
        
        creatTable()
        
    }
    
    
    func creatTable() {
        self.mainTableView = UITableView(frame: view.bounds, style: .plain)
        //  mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifer)
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.navigationItem.title = "Команда разработки"
        self.mainTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell" )
        
        
        mainTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mainTableView)
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case self.mainTableView:
            return self.developer.count
        default:
            return 0
        }
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.developer[indexPath.row]
        return cell
    }
    
    //---UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    //---UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

class TableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
