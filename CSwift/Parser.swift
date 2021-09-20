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
            case .op:
                currentLine.append(token.str)
            }
        }
        
        if currentLine.count > 0 {
            result.append(currentLine.joined(separator: " "))
        }
        
        return result
    }
    
}
