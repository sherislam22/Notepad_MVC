//
//  TextDocument.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 10/8/22.
//

import UIKit

class TextDocument: UIDocument {
    
    var text: String = ""
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return text.data(using: .utf8) ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let data = contents as? Data {
            text = String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    func find(_ string: String) {
        
    }
}
