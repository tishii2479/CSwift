//
//  Parser.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

protocol Parser {
    func parse(tokens: [Token]) -> [String]?
}

public class CSwiftParser: Parser {
    func parse(tokens: [Token]) -> [String]? {
        var result: [String] = []
        var currentLine: [String] = []
        
        for token in tokens {
            switch token.kind {
            case .num:
                currentLine.append(token.str)
            case .plus, .minus, .mul, .div, .equal, .assign,
                 .lBrace, .rBrace, .lBracket, .rBracket:
                currentLine.append(token.str)
            case .variable:
                currentLine.append(token.str)
            case .var:
                currentLine.append("auto")
            case .let:
                currentLine.append("const auto")
            case .true, .false:
                currentLine.append(token.str)
            case .if:
                currentLine.append(token.str)
            }
        }
        
        if currentLine.count > 0 {
            result.append(currentLine.joined(separator: " ") + ";")
        }
        
        return result
    }
}
