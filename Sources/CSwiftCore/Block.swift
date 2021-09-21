//
//  Block.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

import Foundation

struct Block: Node {
    private var tokens: [Token] = []
    
    var convertValue: String {
        "{\n}"
    }
    
    mutating func appendToken(_ token: Token) {
        tokens.append(token)
    }
}
