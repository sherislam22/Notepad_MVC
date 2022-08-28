
//  TextViewer+SearchAndReplaceExt.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Nargiza Beishekenova on 19/8/22.
//

import Foundation
import UIKit

extension TextViewer {
    
    enum Mode {
        case `default`
        case searchAndReplace
    }
    func setupSearchAndReplaceView() {
        stackView.insertArrangedSubview(searchAndReplaceView, at: 0)
        searchAndReplaceView.setSearchTextFieldDelegate(self)
        searchAndReplaceView.setReplaceTextFieldDelegate(self)
        searchAndReplaceView.setTargetToDoneButton(self, #selector(closeSearchView), .touchUpInside)
    }
    
    func setupSearchAndReplaceButtonView() {
        stackView.addArrangedSubview(searchAndReplaceButtonView)
        searchAndReplaceButtonView.backButton.addTarget(self,
                                                        action: #selector(jumpToPreviousSearch),
                                                        for: .touchUpInside)
        searchAndReplaceButtonView.nextButton.addTarget(self,
                                                        action: #selector(jumpToNextSearch),
                                                        for: .touchUpInside)
        searchAndReplaceButtonView.replaceButton.addTarget(self, action: #selector(replaceSearchText), for: .touchUpInside)
        searchAndReplaceButtonView.replaceAllButton.addTarget(self, action: #selector(replaceAllSearchText), for: .touchUpInside)
    }
    
    @objc func closeSearchView() {
        mode = .default
    }
    
    func highlightRanges(_ ranges: [NSRange]) {
        self.ranges = ranges
        updateHighlighting()
    }
    
    func updateHighlighting() {
        let newAttributedText = NSMutableAttributedString(string: textView.text, attributes: [.font : textView.font ?? .systemFont(ofSize: UIFont.systemFontSize)])
        ranges.enumerated().forEach { index, range in
            let color = index == selectedRangeIndex ? UIColor.green : UIColor.yellow
            newAttributedText.addAttribute(.backgroundColor, value: color, range: range)
        }
        textView.attributedText = newAttributedText
//        setAttributedText(newAttributedText)
    }

    @objc func jumpToPreviousSearch() {
        guard !ranges.isEmpty else { return }
        selectedRangeIndex -= 1
        if selectedRangeIndex < 0 {
            selectedRangeIndex = ranges.count - 1
        }
        updateHighlighting()
        textView.scrollRangeToVisible(ranges[selectedRangeIndex])
//        performScrollRangeToVisible(ranges[selectedRangeIndex])
    }
    
    @objc func jumpToNextSearch() {
        guard !ranges.isEmpty else { return }
        selectedRangeIndex += 1
        if selectedRangeIndex >= ranges.count {
            selectedRangeIndex = 0
        }
        updateHighlighting()
        textView.scrollRangeToVisible(ranges[selectedRangeIndex])
//        performScrollRangeToVisible(ranges[selectedRangeIndex])
    }
    
    @objc func replaceSearchText() {
        guard !ranges.isEmpty else { return }
        textController?.replace(ranges: [ranges[selectedRangeIndex]],
                                                       replaceString: searchAndReplaceView.getTextReplaceTextField() ?? "")
        textController?.search(searchAndReplaceView.getTextSearchTextField() ?? "")
    }
    @objc func replaceAllSearchText() {
        textController?.replace(ranges: ranges, replaceString: searchAndReplaceView.getTextReplaceTextField() ?? "")
        textController?.search(searchAndReplaceView.getTextSearchTextField() ?? "")
    }
}
extension TextViewer: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == searchAndReplaceView.getSearchTextField() || textField == searchAndReplaceView.getReplaceTextField()),
           let text = searchAndReplaceView.getTextSearchTextField()
        {
            textController?.search(text)
            textField.resignFirstResponder()
            selectedRangeIndex = 0
            if !ranges.isEmpty {
                textView.scrollRangeToVisible(ranges[selectedRangeIndex])
//                performScrollRangeToVisible(ranges[selectedRangeIndex])
            }
        }
        return true
    }
}
