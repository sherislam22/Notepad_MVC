//
//  NotePadToolBar.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 11/8/22.
//

import UIKit

class NotePadToolBar: UIToolbar {
    //MARK: Toolbar's properties
    private let flexibleSpace: UIBarButtonItem
    private var tempToolBarItems: [UIBarButtonItem]
    private var goToRight: Bool
    private let pasteboard: UIPasteboard
    var textToCopy: String
    public var textController: TextController?
//    let textViewer: TextViewer
    
    override init(frame: CGRect) {
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        goToRight = false
        tempToolBarItems = []
        textToCopy = ""
        pasteboard = UIPasteboard.general
//        textViewer = TextViewer()
        super.init(frame: frame)
        setupToolBar()
    }
    
    required init?(coder: NSCoder) {
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        goToRight = false
        tempToolBarItems = []
        textToCopy = ""
        pasteboard = UIPasteboard.general
//        textViewer = TextViewer()
        super.init(coder: coder)
        setupToolBar()
    }
    
    func setupToolBar() {
        changeStateOfToolbar()
        sizeToFit()
        setItems(tempToolBarItems, animated: false)
    }
    
    func changeStateOfToolbar() {
        tempToolBarItems.removeAll()
        if !goToRight {
            let fontSize = UIBarButtonItem(image: UIImage(systemName: "textformat.size"), style: .plain, target: self, action: nil)
            let fontStyle = UIBarButtonItem(image: UIImage(systemName: "signature"), style: .plain, target: self, action: nil)
            let selectAll = UIBarButtonItem(image: UIImage(systemName: "rectangle.fill.badge.checkmark"), style: .plain, target: self, action: nil)
            let find = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
            let copy = UIBarButtonItem(image: UIImage(systemName: "doc.on.doc"), style: .plain, target: self, action: #selector(copyTapped))
            let rightArrow = UIBarButtonItem(image: UIImage(systemName: "arrow.right.to.line"), style: .plain, target: self, action: #selector(rightArrowTapped))
            
            [fontSize, flexibleSpace, fontStyle, flexibleSpace, selectAll, flexibleSpace, find, flexibleSpace, copy, flexibleSpace, rightArrow].forEach { tempToolBarItems.append($0) }
        } else {
            let leftArrow = UIBarButtonItem(image: UIImage(systemName: "arrow.left.to.line"), style: .plain, target: self, action: #selector(leftArrowTapped))
            let replace = UIBarButtonItem(image: UIImage(systemName: "repeat.circle"), style: .plain, target: self, action: nil)
            let goTo = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: self, action: nil)
            let timeAndDate = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: nil)
            let remove = UIBarButtonItem(image: UIImage(systemName: "trash.slash.circle"), style: .plain, target: self, action: nil)
            let cut = UIBarButtonItem(image: UIImage(systemName: "scissors"), style: .plain, target: self, action: #selector(cutTapped))
            
            [leftArrow, flexibleSpace, replace, flexibleSpace, goTo, flexibleSpace, remove, flexibleSpace, cut, flexibleSpace, timeAndDate].forEach { tempToolBarItems.append($0) }
        }
    }
    
    @objc func copyTapped(_ sender: UIButton) {
        pasteboard.string = textToCopy
    }
    
    @objc func rightArrowTapped(_ sender: UIButton) {
        goToRight = !goToRight
        changeStateOfToolbar()
        self.setItems(tempToolBarItems, animated: true)
    }
    
    @objc func leftArrowTapped(_ sender: UIButton) {
        goToRight = !goToRight
        changeStateOfToolbar()
        self.setItems(tempToolBarItems, animated: true)
    }
    
    @objc func cutTapped(_ sender: UIButton) {
        pasteboard.string = textToCopy
        
    }
}
