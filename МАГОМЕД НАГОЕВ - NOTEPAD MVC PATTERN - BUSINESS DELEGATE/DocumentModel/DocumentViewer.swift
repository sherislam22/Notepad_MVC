//
//  DocumentViewer.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 17/8/22.
//

import UIKit

class DocumentViewer: UIViewController {
    
    private var collectionView: UICollectionView!
    private let cellId: String
    public var documentController: DocumentController?
    
    init() {
        cellId = "DocumentCollectionViewCell"
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.collectionView.dataSource = self

        self.collectionView.register(DocumentCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.delegate = self
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

extension DocumentViewer: UICollectionViewDataSource,
                            UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentController?.getCountUrls() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? DocumentCollectionViewCell
        
        guard let documentController = documentController,
                let cell = cell else {
            return DocumentCollectionViewCell() }
        
        let name = documentController.getFileName(index: indexPath.item)
        
        cell.setDataCell(fileType: "NTP",
                          fileName: name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let documentController = documentController else { return }
        let path = documentController.getPath(index: indexPath.item)
        documentController.setTextForTextViewer(path: path)
    }
}

