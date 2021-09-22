//
//  Tokenizer.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

protocol Tokenizer {
    func tokenize(input: String) -> [Token]?
}

class SwiftTokenizer: Tokenizer {
    func tokenize(input: String) -> [Token]? {
        var tokens: [Token] = []
    
        for line in input.split(whereSeparator: \.isNewline) {
            let line = String(line)
            for s in format(input: line).split(whereSeparator: \.isWhitespace) {
                let s = String(s)
                
                // check reserved tokens
                if let token = Token.reservedToken(s) {
                    tokens.append(token)
                    continue
                }
                
                if let token = Token.convertToken(s) {
                    tokens.append(token)
                    continue
                }
                
                Logger.error("Failed to tokenize: '\(input)' at '\(s)'")
            }
            tokens.append(Token(kind: .endl))
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
            if input[idx].isSymbol != input[input.index(after: idx)].isSymbol {
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
