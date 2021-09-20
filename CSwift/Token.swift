//
//  Token.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

enum Reserved: String, CaseIterable {
    case `var` = "var"
}

struct Token {
    enum Kind {
        case num        // 0-9
        case op         // +,-,*,/,=
        case reserved   // var
        case variable   // hoge, fuga
    }
    
    let kind: Kind
    let str: String
    let val: Int64?
    let reserved: Reserved?
    
    init(
        kind: Kind,
        str: String,
        val: Int64? = nil,
        reserved: Reserved? = nil
    ) {
        self.kind = kind
        self.str = str
        self.val = val
        self.reserved = reserved
    }
}
