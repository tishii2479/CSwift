//
//  Tokenizer.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

protocol Tokenizer {
    func tokenize(input: String) -> [Token]?
}

class SwiftTokenizer: Tokenizer {
    func tokenize(input: String) -> [Token]? {
        var tokens: [Token] = []
    
        for s in format(input: input).split(whereSeparator: \.isWhitespace) {
            let s = String(s) // TODO: check performance
            
            var isTokenized: Bool = false
            
            // check reserved tokens
            for reserved in Token.Kind.reserved {
                if reserved.isConvertable(s) {
                    tokens.append(Token(kind: reserved, str: reserved.rawValue))
                    isTokenized = true
                    break
                }
            }
            if isTokenized { continue }
            
            for kind in Token.Kind.allCases {
                if Token.Kind.reserved.contains(kind) { continue }
                if kind.isConvertable(s) {
                    tokens.append(Token(kind: kind, str: s))
                    isTokenized = true
                    break
                }
            }
            
            if isTokenized { continue }
            
            Logger.error("Failed to tokenize: '\(s)'")
        }

        return tokens
    }
    
    private func format(input: String) -> String {
        var result: String = ""
        
        guard input.count > 0 else { return "" }

        for i in 0 ..< input.count - 1 {
            let idx = input.index(input.startIndex, offsetBy: i)
            
            // if adjacent letters is a pair of operator and letter,
            // insert a space.
            if (input[idx].isSymbol != input[input.index(after: idx)].isSymbol) {
                result.append(input[idx])
                result.append(" ")
            }
            else {
                result.append(input[idx])
            }
        }
        
        let idx = input.index(input.startIndex, offsetBy: input.count - 1)
        result.append(input[idx])
        
        return result
    }
}
