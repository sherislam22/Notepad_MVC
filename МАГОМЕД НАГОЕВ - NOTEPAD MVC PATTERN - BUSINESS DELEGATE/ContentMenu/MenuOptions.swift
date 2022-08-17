//
//  MenuOptions.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 17/8/22.
//

import Foundation

enum MenuOptions: String, CaseIterable {
    case new = "New"
    case open = "Open"
    case save = "Save"
    case saveAs = "Save as"
    case print = "Print"
    case info = "Info"
    
    var imageName: String {
        switch self {
        case .new:
            return "doc.badge.plus"
        case .open:
            return "envelope.open"
        case .save:
            return "square.and.arrow.down"
        case .saveAs:
            return "square.and.arrow.down.on.square"
        case .print:
            return "printer"
        case .info:
            return "info.circle"
        }
    }
}
