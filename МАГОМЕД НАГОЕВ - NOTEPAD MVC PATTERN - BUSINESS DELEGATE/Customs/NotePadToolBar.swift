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
        fontData.setFontPickerDelegate(delegate: self)
        fontData.setFontSizeDataSource(dataSource: self)
        fontData.setFontSizeDelegate(delegate: self)
    }
    
    func changeStateOfToolbar() {
        tempToolBarItems.removeAll()
        if !goToRight {
            let fontSize = UIBarButtonItem(image: UIImage(systemName: "textformat.size"), style: .plain, target: self, action: #selector(setFontSize))
            let fontStyle = UIBarButtonItem(image: UIImage(systemName: "signature"), style: .plain, target: self, action: #selector(setFont))
            let selectAll = UIBarButtonItem(image: UIImage(systemName: "rectangle.fill.badge.checkmark"), style: .plain, target: self, action: #selector(selectWholeText))
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
    
    @objc func selectWholeText() {
        notePadDelegate?.selectWholeTextDelegate()
    }
    
    @objc func setFont() {
        let fontPicker = fontData.getFontPicker()
        notePadDelegate?.presentFontPicker(fontPicker: fontPicker)
    }
    
    @objc func setFontSize() {
        let alert = UIAlertController(title: "Select size", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let fontSizePickerView = fontData.getFontSizePicker()

        alert.view.addSubview(fontSizePickerView)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

            self.notePadDelegate?.updateFont(font: self.fontData.getFontValue())

        }))
        
        notePadDelegate?.presentAlert(alert: alert)
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

extension NotePadToolBar: UIFontPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //    PICKER VIEW PROTOCOL STUBS
        
        func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
            viewController.dismiss(animated: true, completion: nil)
        }

        func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
            viewController.dismiss(animated: true, completion: nil)
            guard let descriptor = viewController.selectedFontDescriptor else {return}
            let selectedFont = UIFont(descriptor: descriptor, size: fontData.getFontSize())
            
            fontData.setCurrentFontValue(selectedFont)
            notePadDelegate?.updateFont(font: selectedFont)
        }
    
    
//    ALERT WITH PICKER VIEW PROTOCOL STUBS
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let fontSizes = fontData.getFontSizes()
        return fontSizes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let fontSizes = fontData.getFontSizes()
        return String(fontSizes[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fontData.setCurrentFontValue(UIFont(name: fontData.getFontValue().fontName, size: CGFloat(fontData.getFontSizes()[row]))!)
    }

}
