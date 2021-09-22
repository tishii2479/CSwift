//
//  Block.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

class Block: Convertable {
    var prevStatement: Statement?
    private var statements: [Statement] = []
    
    var convertValue: String {
        var result: String = ""
        if let statement = prevStatement {
            result += statement.convertValue
        }
        
        // remove last semicolon
        result.popLast()
        result += " {\n"
    
        for statement in statements {
            result += statement.convertValue + "\n"
        }
        
        result += "}"
        return result
    }
    
    func appendStatement(_ statement: Statement) {
        statements.append(statement)
    }
}
