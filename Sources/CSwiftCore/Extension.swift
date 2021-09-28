//
//  Extension.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

extension Character {
    var isSymbol: Bool {
        let ops: [Character] = ["+", "-", "*", "/", "=", "(", "{", ")", "}", ",", "<", ">"]
        return ops.contains(self)
    }
    
    var isBracket: Bool {
        let brs: [Character] = ["(", ")", "{", "}", "[", "]"]
        return brs.contains(self)
    }
}
