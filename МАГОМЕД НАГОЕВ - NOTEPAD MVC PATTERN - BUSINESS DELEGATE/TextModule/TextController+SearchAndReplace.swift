//
//  TextController+SearchAndReplace.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Nargiza Beishekenova on 18/8/22.
//

import UIKit

extension TextController {
    func search(_ string: String) {
        let allText = textViewer.getText() as NSString
        var searchRange = NSRange(location: 0, length: allText.length)
        var result = [NSRange]()
        while true {
            let foundRange = allText.range(of: string, range: searchRange)
            if foundRange.location != NSNotFound {
                result.append(foundRange)
                let newSearchRangeLocation = foundRange.location + foundRange.length
                searchRange = NSRange(location: newSearchRangeLocation,
                                      length: allText.length - newSearchRangeLocation)
            } else {
                break
            }
        }
        textViewer.highlightRanges(result)
    }
    func replace(ranges: [NSRange], replaceString: String) {
        let allText = textViewer.getText()
        var result = allText
        for range in ranges.reversed() {
            result = (result as NSString).replacingCharacters(in: range, with: replaceString)
        }
        textViewer.updateTextView(text: result)
    }
}
