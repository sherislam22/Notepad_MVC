import UIKit

//    в TextViewer надо добавить функции и объектную переменную FontSizePickerAlert
//
//    private var fontSizePickerAlert: FontSizePickerAlert?
//
//    fontSizePickerAlert = FontSizePickerAlert(self)
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
    
//    ALERT: Deleting current file
    
    @objc func didTapNewFile(){
        let alert = UIAlertController(title: "Delete current file?", message: "Are you sure you want to delete the current file and open new?", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Delete", style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        print("Test ////// deleting file")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        alert.view.addSubview(UIView())
        
        present(alert, animated: true, completion: nil)
    }

//    ALERT: Saving file name

    @objc func didTapSaveButton(){
        let alert = UIAlertController(title: "Name the file", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let txtField = alert.textFields?.first, let text = txtField.text {
                // operations
                print("Test ////// File name: " + text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
        alert.view.addSubview(UIView())
        alert.addTextField { (textField) in
            textField.placeholder = "File name"
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
//    ALERT WITH PICKER VIEW: Picking font size
    
    @objc func didTapPickFontSize(){
        let alert = UIAlertController(title: "Select size", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let fontSizePickerView = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))
        
        let fontSizePickerAlert = getFontSizePickerAlert()
        let fontFamilyName = self.getTextViewFont().fontName
        fontSizePickerAlert.setFontValue(UIFont(name: fontFamilyName, size: CGFloat(fontSizePickerAlert.getFontSizes()[0]))!)
        
        alert.view.addSubview(fontSizePickerView)
        
        fontSizePickerView.dataSource = self
        fontSizePickerView.delegate = self

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            self.setTextViewFont(fontSizePickerAlert.getFontValue())
            
        }))
        present(alert, animated: true, completion: nil )
    }
    
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
    
//    PICKER VIEW: Picking font family and style
    
    @objc func didTapPickFont(){
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true
        let fontPicker = UIFontPickerViewController(configuration: config)
        fontPicker.delegate = self
        present(fontPicker, animated: true)
        
    }
    
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        guard let descriptor = viewController.selectedFontDescriptor else {return}
        let selectedFont = UIFont(descriptor: descriptor, size: 24)
        setTextViewFont(selectedFont)
    }
}
