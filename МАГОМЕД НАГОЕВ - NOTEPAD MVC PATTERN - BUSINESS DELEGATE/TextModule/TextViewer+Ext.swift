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

}
