//
//  NotePadToolBar.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 11/8/22.
//

import UIKit

class NotePadToolBar: UIToolbar {
    //MARK: Toolbar's properties
    let flexibleSpace: UIBarButtonItem
    var tempToolBarItems: [UIBarButtonItem]
    var goToRight: Bool
    var textToCopy: String
    private var fontData = FontData()
    weak var notePadDelegate: NotePadToolbarDelegate?
    
    override init(frame: CGRect) {
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        goToRight = false
        tempToolBarItems = []
        textToCopy = ""
        super.init(frame: frame)
        setupToolBar()
    }
    
    required init?(coder: NSCoder) {
        flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        goToRight = false
        tempToolBarItems = []
        textToCopy = ""
        super.init(coder: coder)
        setupToolBar()
    }
    
    func setupToolBar() {
        changeStateOfToolbar()
        sizeToFit()
        setItems(tempToolBarItems, animated: false)
        fontData.fontPicker.delegate = self
    }
    
    func changeStateOfToolbar() {
        tempToolBarItems.removeAll()
        if !goToRight {
            let fontSize = UIBarButtonItem(image: UIImage(systemName: "textformat.size"), style: .plain, target: self, action: #selector(setFont))
            let fontStyle = UIBarButtonItem(image: UIImage(systemName: "signature"), style: .plain, target: self.fontData, action: nil)
            let selectAll = UIBarButtonItem(image: UIImage(systemName: "rectangle.fill.badge.checkmark"), style: .plain, target: self, action: #selector(test))
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
            let cut = UIBarButtonItem(image: UIImage(systemName: "scissors"), style: .plain, target: self, action: nil)
            
            [leftArrow, flexibleSpace, replace, flexibleSpace, goTo, flexibleSpace, remove, flexibleSpace, cut, flexibleSpace, timeAndDate].forEach { tempToolBarItems.append($0) }
        }
    }
    
    @objc func test() {
        notePadDelegate?.selectWholeTextDelegate()
    }
    
    @objc func setFont() {
        let fontPicker = fontData.fontPicker
        notePadDelegate?.presentFontPicker(fontPicker: fontPicker)
//        fontData.didTapPickFont()
//        notePadDelegate?.updateFont(font: fontValue)
    }
    
    @objc func copyTapped(_ sender: UIButton) {
        UIPasteboard.general.string = textToCopy
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
}

protocol NotePadToolbarDelegate: AnyObject {
    func updateFont(font: UIFont)
    
    func presentAlert(alert: UIAlertController)
    
    func presentFontPicker(fontPicker: UIFontPickerViewController)
    
    func selectWholeTextDelegate()
}

extension NotePadToolBar: UIFontPickerViewControllerDelegate {
    
    //    PICKER VIEW PROTOCOL STUBS
        
        func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
            viewController.dismiss(animated: true, completion: nil)
        }

        func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
            viewController.dismiss(animated: true, completion: nil)
            guard let descriptor = viewController.selectedFontDescriptor else {return}
            let fontSize = fontData.fontValue.pointSize
            let selectedFont = UIFont(descriptor: descriptor, size: fontSize)
            
            notePadDelegate?.updateFont(font: selectedFont)
            
            print("Picker view protocol woooooorks!!")
    //        setTextViewFont(selectedFont)
        }

}
