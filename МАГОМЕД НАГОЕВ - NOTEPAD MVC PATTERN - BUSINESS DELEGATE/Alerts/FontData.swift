import UIKit

class FontData: NSObject {
    
    private let fontSizes: Array<Int>
    private var fontValue: UIFont
    private let fontPicker: UIFontPickerViewController
    private let fontSizePicker: UIPickerView
    
    override init() {
        fontSizes = Array(16...47)
        fontValue = UIFont(name: "Arial", size: 16)!
        
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true
        fontPicker = UIFontPickerViewController(configuration: config)
        
        fontSizePicker = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))
    }
    
    func getFontSizes() -> Array<Int> {
        return fontSizes
    }
    
    func getFontValue() -> UIFont {
        return fontValue
    }
    
    func setCurrentFontValue(_ font: UIFont) {
        fontValue = font
    }
    
    func getFontSize() -> CGFloat {
        return fontValue.pointSize
    }
    
    func getFontPicker() -> UIFontPickerViewController {
        return fontPicker
    }
    
    func setFontPickerDelegate(delegate: UIFontPickerViewControllerDelegate) {
        fontPicker.delegate = delegate
    }
    
    func setFontSizeDataSource(dataSource: UIPickerViewDataSource) {
        fontSizePicker.dataSource = dataSource
    }
    
    func setFontSizeDelegate(delegate: UIPickerViewDelegate) {
        fontSizePicker.delegate = delegate
    }
    
    func getFontSizePicker() -> UIPickerView {
        return fontSizePicker
    }
    
    //    ALERT: Deleting current file
        
    func getAlertNewFile() -> UIAlertController {
        let alert = UIAlertController(title: "Delete current file?", message: "Are you sure you want to delete the current file and open new?", preferredStyle: .alert)

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

//    ALERT: Saving file name

    func getAlertNameTheFile() -> UIAlertController {
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

        
        return alert
        
    }
}
