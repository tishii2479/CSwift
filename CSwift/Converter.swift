//
//  Converter.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

protocol Converter {
    
    func convert(input: String) -> String?
    
}

struct Token {
    
    enum Kind {
        case num
    }
    
    let kind: Kind
    let str: String
    let val: Int64
    
}

protocol Tokenizer {
    
    func tokenize(input: String) -> [Token]?
    
}

class SwiftTokenizer: Tokenizer {
    
    func tokenize(input: String) -> [Token]? {
        var tokens: [Token] = []
        
        for s in input.split(separator: " ") {
            let s = String(s)
            switch s[s.startIndex] {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                guard let val = Int64(s) else {
                    Logger.error("Failed to parse to number: \(s)")
                    return nil
                }
                tokens.append(Token(kind: .num, str: s, val: val))
            default:
                Logger.error("Unexpected character: \(s[s.startIndex])")
                return nil
            }
        }
        
        Logger.debug(tokens)
        
        return tokens
    }
    
}

protocol Parser {
    
    func parse(tokens: [Token]) -> [String]?
    
}

public class CSwiftParser: Parser {
    
    func parse(tokens: [Token]) -> [String]? {
        var result: [String] = []
        
        for token in tokens {
            switch token.kind {
            case .num:
                result.append(token.str)
            }
        }
        
        return result
    }
    
}

public class CSwiftConverter: Converter {
    
    public init() {}
    
    public func convert(input: String) -> String? {
        let source = CSource()
        source.appendLine(line: "int main() {")
        
        // Convert swift code to cpp
        source.appendLines(lines: swiftToC(input: input))
        
        source.appendLine(line: "}")
        
        Logger.debug(source.output(), type: .code)
        return source.output()
    }
    
    private func swiftToC(input: String) -> [String]? {
        let tokens = SwiftTokenizer().tokenize(input: input)!
        
        return CSwiftParser().parse(tokens: tokens)!
    }
    
}
