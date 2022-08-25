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
    
    let identifer = "TableViewCell"
    
    
    
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
            userArr.shuffle()
    }
    
    
    func creatTable() {
        mainTableView.frame = self.view.frame
        self.mainTableView = UITableView(frame: view.bounds, style: .plain)
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.navigationItem.title = "Команда разработки"
        mainTableView.separatorColor = UIColor.clear
        mainTableView.backgroundColor = UIColor.white
        
        mainTableView.register(CastomTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as?
            CastomTableViewCell else {fatalError("unabel to crate cell")}
        cell.userImage.image = userArr[indexPath.row].userImage
        cell.userLabel.text = userArr[indexPath.row].userLabel
        
        return cell
      }
    
    //---UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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

