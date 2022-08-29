import UIKit

class FontData: NSObject {
    
    // MARK: Properties
    private let fontSizes: Array<Int>
    private var fontValue: UIFont
    private let fontPicker: UIFontPickerViewController
    private let fontSizePicker: UIPickerView
    
    // MARK: Initializer
    override init() {
        fontSizes = Array(10...47)
        fontValue = UIFont(name: "Arial", size: 10)!
        
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true
        fontPicker = UIFontPickerViewController(configuration: config)
        
        fontSizePicker = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))
    }
    
    // MARK: Getters and setters
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
}
