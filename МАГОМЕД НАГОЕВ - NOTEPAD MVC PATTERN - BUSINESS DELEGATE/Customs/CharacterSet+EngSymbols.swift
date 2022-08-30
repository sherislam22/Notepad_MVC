//
//  CharacterSet+EngSymbols.swift
//  МАГОМЕД НАГОЕВ - NOTEPAD MVC PATTERN - BUSINESS DELEGATE
//
//  Created by Nargiza Beishekenova on 30/8/22.
//

import Foundation

extension CharacterSet {
    
    static let fileNameCharacterSet = CharacterSet(
        charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        .union(.decimalDigits)
        .union(.punctuationCharacters)
}
