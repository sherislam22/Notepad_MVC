//
//  InformationViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//
//
//import UIKit
//
//class InformationViewController: UIViewController {
//
//    var mainTableView = UITableView()
//
//    private var developer = ["Бекболсун Таалайбеков", "Акунова Бегайым", "Наргиза Бейшекенова", "Памирбек Алмазбеков", "Шерислам Талатбеков", "Бексултан Маратов", "Магомед Нагоев",]
//
//
//
//    //MARK: --------------------------------------------override--------------------------------------
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            setTableView()
//
//    }
//
//    func setTableView() {
//        mainTableView.frame = self.view.frame
//        mainTableView.backgroundColor = .gray
//        mainTableView.delegate = self
//        mainTableView.dataSource = self
//        self.view.addSubview(mainTableView)
//
//        self.mainTableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell" )
//
//        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//    }
//
//}
//
//extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch tableView {
//            case self.mainTableView:
//                return self.developer.count
//            default:
//                return 0
//            }
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath)
////        cell.textLabel?.text = "\(indexPath.row)"
////        return cell
////    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
//            cell.textLabel?.text = self.developer[indexPath.row]
//            return cell
//
//    }
//
//    class TableViewCell: UITableViewCell {
//        override func prepareForReuse() {
//            super.prepareForReuse()
//            self.accessoryType = .none
//        }
//    }
//}
//

import UIKit

class UserModal {
    var userImage: UIImage?
    var userLabel: String?
    
    
    init(userImage: UIImage, userLabel: String) {
        
        self.userImage = userImage
        self.userLabel = userLabel
    }
}

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userArr = [UserModal]()
    
    var mainTableView = UITableView()
    
    
    //var mainTableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    let identifer = "TableViewCell"
    
    
    private var developer = ["Бекболсун Таалайбеков", "Акунова Бегайым", "Наргиза Бейшекенова", "Памирбек Алмазбеков", "Шерислам Талатбеков", "Бексултан Маратов", "Магомед Нагоев",]
    
    
    //MARK: --------------------------------------------override--------------------------------------
        override func viewDidLoad() {
        super.viewDidLoad()
        creatTable()
        
            userArr.append(UserModal(userImage: UIImage(named: "bek")!, userLabel: "Бекболсун Таалайбеков"))
            userArr.append(UserModal(userImage: UIImage(named: "begai")!, userLabel: "Акунова Бегайым"))
            userArr.append(UserModal(userImage: UIImage(named: "nargiza")!, userLabel: "Наргиза Бейшекенова"))
            userArr.append(UserModal(userImage: UIImage(named: "pamir")!, userLabel: "Памирбек Алмазбеков"))
            userArr.append(UserModal(userImage: UIImage(named: "sherislam")!, userLabel: "Шерислам Талатбеков"))
            userArr.append(UserModal(userImage: UIImage(named: "beks")!, userLabel: "Бексултан Маратов"))
            userArr.append(UserModal(userImage: UIImage(named: "magomed")!, userLabel: "Магомед Нагоев"))
        
        
    }
    
    
    func creatTable() {
        mainTableView.frame = self.view.frame
        self.mainTableView = UITableView(frame: view.bounds, style: .plain)
        //  mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifer)
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.navigationItem.title = "Команда разработки"
        //self.mainTableView.register(CastomTableViewCell.self, forCellReuseIdentifier: "TableViewCell" )
        mainTableView.separatorColor = UIColor.clear
        mainTableView.backgroundColor = UIColor.white
        
        
        mainTableView.register(CastomTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        //mainTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        view.addSubview(mainTableView)
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case self.mainTableView:
            return self.userArr.count
        default:
            return 0
        }
    }
     
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
//        cell.textLabel?.text = self.developer[indexPath.row]
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as?
            CastomTableViewCell else {fatalError("unabel to crate cell")}
        cell.userImage.image = userArr[indexPath.row].userImage
        cell.userLabel.text = userArr[indexPath.row].userLabel
        
        
        
        //cell.textLabel?.text = self.developer[indexPath.row]//  = "\(indexPath.row)"
        return cell
      }
    
    //---UITableViewDelegate
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 118.0
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
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

