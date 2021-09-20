//
//  Token.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

struct Token {
    enum Kind: String, CaseIterable {
        case num        // 0-9
        case plus       = "+"
        case minus      = "-"
        case mul        = "*"
        case div        = "/"
        case equal      = "=="
        case assign     = "="
        case lBrace     = "{"
        case rBrace     = "}"
        case lBracket   = "("
        case rBracket   = ")"
        case `var`      // var
        case `let`      // let
        case variable   // hoge, fuga
        case `true`     // true
        case `false`    // false
        
        static let operators: [Kind] = [
            .plus, .minus, .mul, .div, .equal, .assign
        ]
        
        static let reserved: [Kind] = [
            .var, .let, .true, .false
        ]
                
        func isConvertable(_ str: String) -> Bool {
            switch self {
            case .num:
                if let _ = Int(str) {
                    return true
                }
                return false
            case .plus, .minus, .mul, .div, .equal, .assign,
                 .lBrace, .lBracket, .rBrace, .rBracket:
                return str == self.rawValue
            case .var:
                return str == "var"
            case .let:
                return str == "let"
            case .variable:
                return str.first?.isLetter == true
            case .true:
                return str == "true"
            case .false:
                return str == "false"
            }
        }
    }
    
    let kind: Kind
    let str: String
    
    init(
        kind: Kind,
        str: String
    ) {
        self.kind = kind
        self.str = str
    }
}
