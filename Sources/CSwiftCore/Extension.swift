//
//  Extension.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

extension Character {
    var isSymbol: Bool {
        let ops: [Character] = ["+", "-", "*", "/", "=", "(", "{", ")", "}", ",", "<", ">"]
        for op in ops {
            if self == op {
                return true
            }
        }
        return false
    }
}
