import UIKit

extension TextViewer: UIFontPickerViewControllerDelegate {
    
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
//        функция для установления шрифта с типом аргумента UIFont
//        setTextViewFont(selectedFont)
    }
}
