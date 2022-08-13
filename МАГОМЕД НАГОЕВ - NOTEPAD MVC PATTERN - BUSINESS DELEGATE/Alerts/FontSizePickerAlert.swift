import UIKit

class FontSizePickerAlert {
    private let fontSizes: Array<Int>
    private var fontValue: UIFont
    private var viewer: TextViewer
    
    init(_ viewer: TextViewer) {
        fontSizes = Array(16...47)
        self.viewer = viewer
        fontValue = self.viewer.getTextViewFont()
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
}
 
