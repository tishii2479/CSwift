//
//  Statement.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

class Statement: Convertable {
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
    
    func append(_ kind: Token.Kind) {
        tokens.append(Token(kind: kind))
    }
    
    func append(_ token: Token) {
        tokens.append(token)
    }
    
    func removeAll() {
        tokens.removeAll()
    }
    
    func removeLast() {
        tokens.removeLast()
    }
}
