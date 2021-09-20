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
    
        for s in input.split(separator: " ") {
            let s = String(s) // TODO: check performance
            
            var isReserved: Bool = false
            // check reserved
            for reserved in Token.Kind.reserved {
                if reserved.isConvertable(s) {
                    tokens.append(Token(kind: reserved, str: reserved.rawValue))
                    isReserved = true
                    break
                }
            }
            if isReserved { continue }
            
            for kind in Token.Kind.allCases {
                if Token.Kind.reserved.contains(kind) { continue }
                if kind.isConvertable(s) {
                    tokens.append(Token(kind: kind, str: s))
                    break
                }
            }
        }

        return tokens
    }
}
