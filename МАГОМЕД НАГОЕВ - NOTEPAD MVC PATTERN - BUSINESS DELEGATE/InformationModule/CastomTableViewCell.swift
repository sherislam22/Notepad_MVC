//
//  CastomTableViewCell.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by bekbolsunjr on 16/8/22.
//

import UIKit
class CastomTableViewCell: UITableViewCell {
    lazy var backeView: UIView = {
        //et view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 110))
        let view = UIView(frame: CGRect(x: 7, y: 7, width: 360, height: 75))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var userImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 4, y: 4, width: 70, height: 70))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var userLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 90, y: 28, width: 190, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backeView.layer.cornerRadius = 5
        backeView.clipsToBounds = true
        userImage.layer.cornerRadius = 36
        userImage.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backeView)
        backeView.addSubview(userImage)
        backeView.addSubview(userLabel)
    }

}
