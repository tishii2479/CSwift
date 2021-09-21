//
//  Extension.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

extension String {
    // TODO: remove
    var isOperator: Token.Kind? {
        for op in Token.Kind.operators {
            if self == op.rawValue {
                return op
            }
        }
        return nil
    }
}

extension Character {
    // TODO: remove
    var isSymbol: Bool {
        let ops: [Character] = ["+", "-", "*", "/", "=", "(", "{", ")", "}", ","]
        for op in ops {
            if self == op {
                return true
            }
        }
        return false
    }
}
