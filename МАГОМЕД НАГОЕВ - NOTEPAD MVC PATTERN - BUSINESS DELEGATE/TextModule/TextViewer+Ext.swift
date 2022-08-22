import UIKit

extension TextViewer: NotePadToolbarDelegate {
    
    func updateFont(font: UIFont) {
        updateTextViewFont(font: font)
    }

    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func presentFontPicker(fontPicker: UIFontPickerViewController) {
        present(fontPicker, animated: true)
    }
    
    func selectWholeTextDelegate() {
        selectWholeText()
    }

    func cutSelectedTextDelegate(text: String) {
        cutSelectedText(text: text)
    }
    
    func pasteCopiedTextDelegate(text: String) {
        pasteCopiedText(text: text)
    }
    
    func dataAndTimeDeligate() {
        dataAndTime()
    }
    
    func removeSelectedTextDalegate(text: String) {
        let updatedText = getText().replacingOccurrences(of: text, with: "")
        updateTextView(text: updatedText)
    }
}
