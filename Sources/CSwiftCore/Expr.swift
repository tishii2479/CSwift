//
//  Expr.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

import Foundation

struct Expr: Node {
    private var tokens: [Token] = []
    
    var convertValue: String {
        return "true"
    }
    
    mutating func appendToken(_ token: Token) {
        tokens.append(token)
    }
}
