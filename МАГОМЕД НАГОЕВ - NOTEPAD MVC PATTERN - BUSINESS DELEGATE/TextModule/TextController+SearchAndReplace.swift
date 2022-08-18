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
}
