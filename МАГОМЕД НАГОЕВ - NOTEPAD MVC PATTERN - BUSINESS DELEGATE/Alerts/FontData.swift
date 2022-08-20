import UIKit

class FontData: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    private let fontSizes: Array<Int>
    var fontValue: UIFont
    
    let fontPicker: UIFontPickerViewController
//    private var viewer: TextViewer
    
//    init(_ viewer: TextViewer) {
//        fontSizes = Array(10...47)
//        self.viewer = viewer
//        fontValue = UIFont()
//    }
    
    
    override init() {
        fontSizes = Array(16...47)
        fontValue = UIFont(name: "Arial", size: 16)!
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true
        fontPicker = UIFontPickerViewController(configuration: config)
    }
    
    func getFontSizes() -> Array<Int> {
        return fontSizes
    }
    
    func getFontValue() -> UIFont {
        return fontValue
    }
    
    func setFontValue(_ font: UIFont) {
        self.fontValue = font
    }
    
    // SELECT ALL
    
//    @objc func selectWholeText() {
//            viewer.textView.selectAll(viewer)
//    }
    
    func testMolmolum() -> UIAlertController {
        let alert = UIAlertController(title: "Molmolum", message: "MOLMOLUM", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Delete", style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        print("Test ////// deleting file")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        alert.view.addSubview(UIView())
        
        
        return alert
    }
    
    
    //    ALERT: Deleting current file
        
    @objc func didTapNewFile() {
        let alert = UIAlertController(title: "Delete current file?", message: "Are you sure you want to delete the current file and open new?", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Delete", style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        print("Test ////// deleting file")
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { _ in })

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        alert.view.addSubview(UIView())
        

        UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
        
        //        UIApplication.shared.windows[0].rootViewController?
    }

//    ALERT: Saving file name

    @objc func didTapSaveButton() {
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

//        textViewer.present(alert, animated: true, completion: nil)
        UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
        
    }

    
    
//    PICKER VIEW: Picking font family and style
//
//    @objc func didTapPickFont(){
//        let config = UIFontPickerViewController.Configuration()
//        config.includeFaces = true
//        let fontPicker = UIFontPickerViewController(configuration: config)
//        fontPicker.delegate = self
//
//        UIApplication.shared.windows[0].rootViewController?.present(fontPicker, animated: true, completion: nil)
//
//
//    }

    //    ALERT WITH PICKER VIEW: Picking the size of the font

    @objc func didTapPickFontSize(){
        let alert = UIAlertController(title: "Select size", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let fontSizePickerView = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))

        let fontFamilyName = fontValue.fontName
        fontValue = UIFont(name: fontFamilyName, size: CGFloat(fontSizes[0]))!

        alert.view.addSubview(fontSizePickerView)

        fontSizePickerView.dataSource = self
        fontSizePickerView.delegate = self

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in

//            self.viewer.setTextViewFont(self.fontValue)
            print("Test from didTapPickFontSize")

        }))
        
        UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: nil)
//        UIApplication.shared.windows[0].rootViewController?.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontSizes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(fontSizes[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fontValue = UIFont(name: fontValue.fontName, size: CGFloat(fontSizes[row]))!
    }
    
////    PICKER VIEW PROTOCOL STUBS
//    
//    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
//        viewController.dismiss(animated: true, completion: nil)
//    }
//
//    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
//        viewController.dismiss(animated: true, completion: nil)
//        guard let descriptor = viewController.selectedFontDescriptor else {return}
//        let fontSize = fontValue.pointSize
//        let selectedFont = UIFont(descriptor: descriptor, size: fontSize)
//        
//        
//        fontValue = selectedFont
//
//        print("Picker view protocol woooooorks!!")
////        setTextViewFont(selectedFont)
//    }


}
