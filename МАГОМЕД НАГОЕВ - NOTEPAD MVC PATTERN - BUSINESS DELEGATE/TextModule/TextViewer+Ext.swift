import UIKit

//    в TextViewer надо добавить функции и объектную переменную FontData
//
//    private var fontData: FontData?
//
//    fontData = FontData(self) // внутри коснтруктора
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
//    public func getFontData() -> FontData {
//        return fontData!
//    }

extension TextViewer: UIFontPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    
//    ALERT WITH PICKER VIEW PROTOCOL STUBS
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let fontData = getFontData()
        return fontData.getFontSizes().count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let fontData = getFontData()
        return String(fontData.getFontSizes()[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let fontData = getFontData()
        fontData.setFontValue(UIFont(name: self.getTextViewFont().fontName, size: CGFloat(fontData.getFontSizes()[row]))!)
    }
    
//    PICKER VIEW PROTOCOL STUBS
    
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        guard let descriptor = viewController.selectedFontDescriptor else {return}
        let fontSize = self.getTextViewFont().pointSize
        let selectedFont = UIFont(descriptor: descriptor, size: fontSize)
        setTextViewFont(selectedFont)
    }
}
