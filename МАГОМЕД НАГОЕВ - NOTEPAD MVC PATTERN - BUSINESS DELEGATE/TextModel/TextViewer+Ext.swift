import UIKit

//    надо добавить функции в TextViewer и объектную переменную FontSizePickerAlert
//
//    public func setTextViewFont(_ font: UIFont){
//        textView.font = font
//    }
//
//    public func getTextViewFont() -> UIFont {
//        guard let font = textView.font else { return UIFont()}
//        return font
//    }
//
//    public func getFontSizePickerAlert() -> FontSizePickerAlert {
//        return fontSizePickerAlert!
//    }

extension TextViewer: UIFontPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let fontSizePickerAlert = getFontSizePickerAlert()
        return fontSizePickerAlert.getFontSizes().count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let fontSizePickerAlert = getFontSizePickerAlert()
        return String(fontSizePickerAlert.getFontSizes()[row])
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let fontSizePickerAlert = getFontSizePickerAlert()
        fontSizePickerAlert.setFontValue(UIFont(name: self.getTextViewFont().fontName, size: CGFloat(fontSizePickerAlert.getFontSizes()[row]))!)
    }
    
    @objc func didTapPickFont(){
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true
        let fontPicker = UIFontPickerViewController(configuration: config)
        fontPicker.delegate = self
        present(fontPicker, animated: true)
        
    }
    
    @objc func testButtonSize(){
        let alert = UIAlertController(title: "Select size", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let fontSizePickerView = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))
        let fontSizePickerAlert = getFontSizePickerAlert()
        fontSizePickerAlert.setFontValue(UIFont(name: self.getTextViewFont().fontName, size: CGFloat(fontSizePickerAlert.getFontSizes()[0]))!)
        
        alert.view.addSubview(fontSizePickerView)
        fontSizePickerView.dataSource = self
        fontSizePickerView.delegate = self

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            
            self.setTextViewFont(fontSizePickerAlert.getFontValue())
            
        }))
        self.present(alert, animated: true, completion: nil )
    }
    
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        guard let descriptor = viewController.selectedFontDescriptor else {return}
        let selectedFont = UIFont(descriptor: descriptor, size: 24)
//        функция для установления шрифта с типом аргумента UIFont
        setTextViewFont(selectedFont)
    }
}
