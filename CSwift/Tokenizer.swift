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
            
            // check reserved
            var isReserved: Bool = false
            for reserved in Reserved.allCases {
                if s == reserved.rawValue {
                    tokens.append(
                        Token(
                            kind: .reserved,
                            str: reserved.rawValue,
                            reserved: reserved
                        )
                    )
                    isReserved = true
                    break
                }
            }
            if isReserved { continue }
            
            let first: Character = s[s.startIndex]
            if first.isNumber {
                guard let val = Int64(s) else {
                    Logger.error("Failed to parse to number: \(s)")
                    return nil
                }
                tokens.append(Token(kind: .num, str: s, val: val))
            }
            else if first.isLetter {
                tokens.append(Token(kind: .variable, str: s))
            }
            else if first.isOperator {
                tokens.append(Token(kind: .op, str: s))
            }
            else {
                Logger.error("Unexpected character: \(s)")
                return nil
            }
        }

        return tokens
    }
}
