//
//  ViewController.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 7/8/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.collectionView.dataSource = self
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let columnNumber = 3
        let itemWidth = ((self.collectionView.bounds.width
                          - flowLayout.sectionInset.left
                          - flowLayout.sectionInset.right
                          - flowLayout.minimumInteritemSpacing * CGFloat(columnNumber - 1))
                         / CGFloat(columnNumber)).rounded(.down)
        
        let itemHeight = itemWidth * 1.2
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = self.data[indexPath.item]
        return cell
    }
}
