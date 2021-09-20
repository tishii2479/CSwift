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
    
        for s in input.split(whereSeparator: \.isWhitespace) {
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
            
            Logger.error("Failed to tokenize: \(s)")
        }

        return tokens
    }
}
