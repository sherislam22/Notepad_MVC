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
    
    func didTapGoToButtonInNotePadToolBar(_ notePadToolBar: NotePadToolBar) {
        textController?.openAnotherDocument()
    }
    
    func didTapFindButtonInNotePadToolBar(_ notePadToolBar: NotePadToolBar) {
        searchAndReplaceView.isReplacingEnabled = false
        searchAndReplaceButtonView.isReplacingEnabled = false
        mode = .searchAndReplace
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func didTapReplaceButtonInNotePadToolBar(_ notePadToolBar: NotePadToolBar) {
        searchAndReplaceView.isReplacingEnabled = true
        searchAndReplaceButtonView.isReplacingEnabled = true
        mode = .searchAndReplace
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
