//
//  Block.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

struct Block {
    private var statements: [Statement] = []
    
    var convertValue: String {
        "{\n}"
    }
    
    mutating func appendStatement(_ statement: Statement) {
        statements.append(statement)
    }
}
