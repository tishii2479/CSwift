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
        case lBr        = "{"
        case rBr        = "}"
        case lBrCur     = "("
        case rBrCur     = ")"
        case `if`       = "if"
        case `var`      // var
        case `let`      // let
        case variable   // hoge, fuga
        case `true`     // true
        case `false`    // false
        case print      // print
        case input      // input
        case endl       = "\n"
        case comma      = ","
        
        static let operators: [Kind] = [
            .plus, .minus, .mul, .div, .equal, .assign
        ]
        
        static let reserved: [Kind] = [
            .if, .var, .let, .true, .false, .print, .input
        ]
                
        func isConvertable(_ str: String) -> Bool {
            switch self {
            case .num:
                if let _ = Int(str) {
                    return true
                }
                return false
            case .plus, .minus, .mul, .div, .equal, .assign,
                 .lBr, .rBr, .lBrCur, .rBrCur,
                 .if, .var, .let,
                 .true, .false, .print, .endl, .input, .comma:
                return str == self.rawValue
            case .variable:
                return str.first?.isLetter == true
            }
        }
    }
    
    let kind: Kind
    let str: String
    
    var convertValue: String {
        switch self.kind {
        case .var:
            return "int"
        case .let:
            return "const int"
        case .num, .variable:
            return str
        default:
            return kind.rawValue
        }
    }
    
    init(
        kind: Kind,
        str: String
    ) {
        self.kind = kind
        self.str = str
    }
}
