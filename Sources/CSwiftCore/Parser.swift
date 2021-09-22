//
//  Parser.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

protocol Parser {
    func parse(tokens: [Token]) -> [String]?
}

public class CSwiftParser: Parser {
    private var ptr = 0
    private var result: [String] = []
    private var statment: Statement = Statement()
    private var tokens: [Token] = []
    
    private func setup() {
        result.removeAll()
        statment = Statement()
        ptr = 0
    }
    
    func parse(tokens: [Token]) -> [String]? {
        setup()
        self.tokens = tokens
        
        while ptr < tokens.count {
            parseStatement()
            endOfLine()
        }
        
        return result
    }
    
    private func parseStatement() {
        while ptr < tokens.count {
            let token = tokens[ptr]

            switch token.kind {
            case .if:
                guard parseIf() else { parseError() }
            case .endl:
                guard read(kind: .endl) != nil else { parseError() }
                return
            case .input:
                guard parseInput() else { parseError() }
            case .print:
                guard parsePrint() else { parseError() }
            default:
                guard consume(kind: token.kind) != nil else { parseError() }
            }
        }
    }
    
    private func endOfLine() {
        result.append(statment.convertValue)
        statment.removeAll()
    }

    private func read(kind: Token.Kind) -> Token? { return read(kind: [kind]) }
    private func read(kind: [Token.Kind]) -> Token? {
        return consume(kind: kind, append: false)
    }
    
    private func consume(kind: Token.Kind, append: Bool = true) -> Token? { return consume(kind: [kind], append: append) }
    private func consume(kind: [Token.Kind], append: Bool = true) -> Token? {
        guard expect(kind: kind) else { return nil }
        
        if append {
            statment.append(tokens[ptr])
        }
        
        ptr += 1
        return tokens[ptr - 1]
    }

    ///
    /// Check next token has the expected kind
    ///
    private func expect(kind: Token.Kind) -> Bool { return expect(kind: [kind]) }
    private func expect(kind: [Token.Kind]) -> Bool {
        if ptr >= tokens.count { return false }
        for k in kind {
            if k == tokens[ptr].kind { return true }
        }
        return false
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
        
        statment.append(Token(kind: .var))
        for (i, variable) in variables.enumerated() {
            statment.append(variable)
            statment.append(.comma)
        }
        statment.removeLast()
        endOfLine()
        
        statment.append(Token(kind: .cName, str: "cin"))
        
        for variable in variables {
            statment.append(.rShift)
            statment.append(variable)
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
        
        statment.append(Token(kind: .cName, str: "cout"))
        for (i, variable) in variables.enumerated() {
            statment.append(.lShift)
            statment.append(variable)
            if i < variables.count - 1 {
                statment.append(.lShift)
                statment.append(.space)
            }
        }
        statment.append(.lShift)
        statment.append(Token(kind: .cName, str: "endl"))
        
        return true
    }
    
    ///
    /// Parse `if expr {}` to `if (expr) {}`
    ///
    private func parseIf() -> Bool {
        guard consume(kind: .if) != nil else { return false }
        
        statment.append(.lBrCur)
        guard expr() else { return false }
        statment.append(.rBrCur)
        
        guard block() else { return false }
        return true
    }
    
    private func expr() -> Bool {
        guard let tok = consume(kind: [.num, .true, .false, .variable]) else { return false }
        return true
    }
    
    private func block() -> Bool {
        guard consume(kind: .lBr) != nil else { return false }
        while read(kind: .endl) != nil { read(kind: .endl) }
        statment.append(.endl)
        guard consume(kind: .rBr) != nil else { return false }
        while read(kind: .endl) != nil { read(kind: .endl) }
        return true
    }
    
    private func parseError() -> Never {
        Logger.error("Failed to parse tokens \(tokens), token: \(tokens[ptr]), at: \(ptr)")
    }
}
