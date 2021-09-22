//
//  Block.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

class Block: Convertable {
    ///
    /// Previous statment of blocks
    /// e.g `if 1 == 1`, `while i < 10`
    ///
    var prevStatement: Statement?
    
    ///
    /// Statements in the block
    ///
    private var statements: [Statement] = []
    
    var convertValue: String {
        var result: String = ""
        if let statement = prevStatement {
            result += statement.convertValue
        }
        
        result.popLast() // remove last semicolon of prevStatement
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
