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
            switch s[s.startIndex] {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                guard let val = Int64(s) else {
                    Logger.error("Failed to parse to number: \(s)")
                    return nil
                }
                tokens.append(Token(kind: .num, str: s, val: val))
            case "+", "-", "*", "/":
                tokens.append(Token(kind: .op, str: s, val: nil))
            default:
                Logger.error("Unexpected character: \(s[s.startIndex])")
                return nil
            }
        }

        return tokens
    }
}
