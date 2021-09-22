//
//  Statement.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

struct Statement: Convertable {
    private(set) var tokens: [Token] = []
    
    var count: Int {
        tokens.count
    }
    
    var convertValue: String {
        var result = ""
        for token in tokens {
            if token.kind.noLeftSpace && result.last == " " {
                result.popLast()
            }
            result += token.convertValue
            if !token.kind.noRightSpace {
                result += " "
            }
        }
        result.popLast()
        return result + ";"
    }
    
    mutating func append(_ kind: Token.Kind) {
        tokens.append(Token(kind: kind))
    }
    
    mutating func append(_ token: Token) {
        tokens.append(token)
    }
    
    mutating func removeAll() {
        tokens.removeAll()
    }
    
    mutating func removeLast() {
        tokens.removeLast()
    }
}
