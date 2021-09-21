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
                guard parseIf() else { parseError() }
            case .endl:
                guard read(kind: .endl) != nil else { parseError() }
                endOfLine()
            case .input:
                guard parseInput() else { parseError() }
            case .print:
                guard parsePrint() else { parseError() }
            default:
                guard consume(kind: token.kind) != nil else { parseError() }
            }
        }
        
        if currentLine.count > 0 {
            endOfLine()
        }
        
        return result
    }
    
    private func endOfLine() {
        result.append(currentLine.joined(separator: " ") + ";")
        currentLine.removeAll()
    }
    
    private func endOfBlock() {
        result.append(currentLine.joined(separator: " "))
        currentLine.removeAll()
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

    ///
    /// Check next token has the expected kind
    ///
    private func expect(kind: Token.Kind) -> Bool {
        if ptr >= tokens.count || kind != tokens[ptr].kind {
            return false
        }
        return true
    }
    
    ///
    /// Parse `input(variable...)` to `cin >> var1 >> var2;`
    ///
    private func parseInput() -> Bool {
        var variables: [Token] = []
        guard read(kind: .input) != nil,
              read(kind: .lBrCur) != nil,
              let var1 = read(kind: .variable)
        else { return false }
        
        variables.append(var1)
        while read(kind: .comma) != nil {
            guard let variable = read(kind: .variable) else { return false }
            variables.append(variable)
        }
        
        guard read(kind: .rBrCur) != nil else { return false }
        
        currentLine.append("int")
        for (i, variable) in variables.enumerated() {
            if i != variables.count - 1 {
                currentLine.append("\(variable.str),")
            }
            else {
                currentLine.append("\(variable.str)")
            }
        }
        
        endOfLine()
        
        currentLine.append("cin")
        
        for variable in variables {
            currentLine.append(">> \(variable.str)")
        }
        
        return true
    }
    
    ///
    /// Parse `print(variable...)` to `cout << var1 << " " << var2 << endl;`
    ///
    private func parsePrint() -> Bool {
        var variables: [Token] = []
        guard read(kind: .print) != nil,
              read(kind: .lBrCur) != nil,
              let var1 = read(kind: .variable)
        else { return false }
        
        variables.append(var1)

        while read(kind: .comma) != nil {
            guard let variable = read(kind: .variable) else { return false }
            variables.append(variable)
        }

        guard read(kind: .rBrCur) != nil else { return false }
        
        currentLine.append("cout")
        for (i, variable) in variables.enumerated() {
            currentLine.append("<< \(variable.str)")
            if i < variables.count - 1 {
                currentLine.append("<< \" \"")
            }
        }
        currentLine.append("<< endl")
        
        return true
    }
    
    ///
    /// Parse `if expr {}` to `if (expr) {}`
    ///
    private func parseIf() -> Bool {
        guard read(kind: .if) != nil,
              let expr = expr(),
              let block = block()
        else { return false }
        
        currentLine.append("if (\(expr.convertValue)) \(block.convertValue)")
        endOfBlock()
        return true
    }
    
    private func expr() -> Expr? {
        var expr = Expr()
        guard let tok = read(kind: .true) else { return nil }
        expr.appendToken(tok)
        return expr
    }
    
    private func block() -> Block? {
        var block = Block()
        guard read(kind: .lBr) != nil else { return nil }
        while read(kind: .endl) != nil { read(kind: .endl) }
        guard read(kind: .rBr) != nil else { return nil }
        while read(kind: .endl) != nil { read(kind: .endl) }
        
        block.appendToken(Token(kind: .lBr))
        block.appendToken(Token(kind: .endl))
        block.appendToken(Token(kind: .rBr))
        return block
    }
    
    private func parseError() -> Never {
        Logger.error("Failed to parse tokens \(tokens), token: \(tokens[ptr]), at: \(ptr)")
    }
}
