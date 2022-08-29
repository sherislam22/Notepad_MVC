//
//  EditCommands.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Нагоев Магомед on 17/8/22.
//

import UIKit

protocol TextWriterProtocol {
    func saveState() -> TextMemento
    func restore(state: TextMemento)
}

final class TextMemento {
    private(set) var text: String
    private(set) var textFont: UIFont
    
    init(text: String,
         textFont: UIFont) {
        self.text = text
        self.textFont = textFont
    }
}

final class CareTaker {
    private var states: [TextMemento]
    private var currentIndex: Int
    private var textWriter: TextWriterProtocol
    
    init(textWriter: TextWriterProtocol) {
        states = []
        currentIndex = 0
        self.textWriter = textWriter
    }
    
    func getStates() -> [TextMemento] {
        return self.states
    }
    
    func removeStates() {
        states.removeAll()
    }
    
    func save() {
        if states.count >= 5 {
            states.removeFirst() }
        
        states.append(textWriter.saveState())
        currentIndex = states.count - 1
    }
    
    func undo() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        
        textWriter.restore(state: states[currentIndex])
    }
    
    func redo() {
        let index = currentIndex + 1
        guard index <= states.count - 1 else { return }
        
        currentIndex = index
        
        textWriter.restore(state: states[index])
    }
}
