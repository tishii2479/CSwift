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
    private var ptr = 0
    private var result: [String] = []
    private var currentLine: [String] = []
    private var tokens: [Token] = []
    
    private func setup() {
        result.removeAll()
        currentLine.removeAll()
        ptr = 0
    }
    
    func parse(tokens: [Token]) -> [String]? {
        setup()
        self.tokens = tokens

        while ptr < tokens.count {
            let token = tokens[ptr]

            switch token.kind {
            case .if:
                guard read(kind: .if) != nil,
                      let expr = read(kind: .true),
                      read(kind: .lBr) != nil,
                      // read block
                      read(kind: .rBr) != nil
                else {
                    Logger.error("Failed to parse: \(token)")
                    return nil
                }

                currentLine.append("if (\(expr.str)) {}")
            case .print:
                guard read(kind: .print) != nil,
                      read(kind: .lBrCur) != nil,
                      let variable = read(kind: .variable),
                      read(kind: .rBrCur) != nil
                else {
                    Logger.error("Failed to parse: \(token)")
                    return nil
                }

                currentLine.append("cout << \(variable.str) << endl")
            default:
                guard consume(kind: token.kind) != nil
                else {
                    Logger.error("Failed to parse: \(token)")
                    return nil
                }
            }
        }
        
        if currentLine.count > 0 {
            result.append(currentLine.joined(separator: " ") + ";")
        }
        
        return result
    }
    
    private func read(kind: Token.Kind) -> Token? {
        return consume(kind: kind, append: false)
    }
    
    private func consume(kind: Token.Kind, append: Bool = true) -> Token? {
        guard expect(kind: kind) else { return nil }
        
        if append {
            currentLine.append(tokens[ptr].convertValue)
        }
        
        ptr += 1
        return tokens[ptr - 1]
    }
    
    private func expect(kind: Token.Kind) -> Bool {
        if ptr >= tokens.count || kind != tokens[ptr].kind {
            return false
        }
        
        return true
    }
}
