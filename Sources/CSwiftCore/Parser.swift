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
    private var blocks: [Block] = []
    private var statement: Statement = Statement()
    private var tokens: [Token] = []
    
    private func setup() {
        result.removeAll()
        statement.removeAll()
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
            default:
                parseStatement()
                endOfStatement()
            }
        }
        
        return result
    }
    
    private func parseStatement() {
        while ptr < tokens.count {
            let token = tokens[ptr]

            switch token.kind {
            case .if:
                parseError()
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
    
    private func endOfStatement() {
        result.append(statement.convertValue)
        statement.removeAll()
    }

    private func read(kind: Token.Kind) -> Token? { return read(kind: [kind]) }
    private func read(kind: [Token.Kind]) -> Token? {
        return consume(kind: kind, append: false)
    }
    
    private func consume(kind: Token.Kind, append: Bool = true) -> Token? { return consume(kind: [kind], append: append) }
    private func consume(kind: [Token.Kind], append: Bool = true) -> Token? {
        guard expect(kind: kind) else { return nil }
        
        if append {
            statement.append(tokens[ptr])
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
        else { parseError() }
        
        variables.append(var1)
        while read(kind: .comma) != nil {
            guard let variable = read(kind: .variable) else { parseError() }
            variables.append(variable)
        }
        
        guard read(kind: .rBrCur) != nil else { parseError() }
        
        statement.append(Token(kind: .var))
        for (i, variable) in variables.enumerated() {
            statement.append(variable)
            statement.append(.comma)
        }

        statement.removeLast()
        endOfStatement()
        
        statement.append(Token(kind: .cName, str: "cin"))
        
        for variable in variables {
            statement.append(.rShift)
            statement.append(variable)
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
        else { parseError() }
        
        variables.append(var1)

        while read(kind: .comma) != nil {
            guard let variable = read(kind: .variable) else { parseError() }
            variables.append(variable)
        }

        guard read(kind: .rBrCur) != nil else { parseError() }
        
        statement.append(Token(kind: .cName, str: "cout"))
        for (i, variable) in variables.enumerated() {
            statement.append(.lShift)
            statement.append(variable)
            if i < variables.count - 1 {
                statement.append(.lShift)
                statement.append(.space)
            }
        }
        statement.append(.lShift)
        statement.append(Token(kind: .cName, str: "endl"))
        
        return true
    }
    
    ///
    /// Parse `if expr {}` to `if (expr) {}`
    ///
    private func parseIf() -> Bool {
        guard consume(kind: .if) != nil else { parseError() }
        
        statement.append(.lBrCur)
        guard parseExpr() else { parseError() }
        statement.append(.rBrCur)
        
        guard parseBlock() else { parseError() }
        return true
    }
    
    private func parseExpr() -> Bool {
        guard let tok = consume(kind: [.num, .true, .false, .variable]) else { parseError() }
        return true
    }
    
    private func parseBlock() -> Bool {
        guard read(kind: .lBr) != nil else { parseError() }
        while read(kind: .endl) != nil { read(kind: .endl) }
        
        let block = Block()
        block.prevStatement = statement
        statement.removeAll()
        
        while !expect(kind: .rBr) {
            parseStatement()
            
            block.appendStatement(statement)
            statement.removeAll()
        }

        guard read(kind: .rBr) != nil else { parseError() }
        while read(kind: .endl) != nil { read(kind: .endl) }
        
        result.append(block.convertValue)
        return true
    }
    
    private func parseError(
        f: String = #function,
        c: String = #file,
        l: Int = #line,
        col: Int = #column
    ) -> Never {
        Logger.error("Failed to parse tokens \(tokens), token: \(tokens[ptr]), at: \(ptr)", f: f, c: c, l: l, col: col)
    }
}
