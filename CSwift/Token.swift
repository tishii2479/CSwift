//
//  Token.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

struct Token {
    enum Kind {
        case num    // 0-9
        case op     // +,-,*,/
    }
    
    let kind: Kind
    let str: String
    let val: Int64?
}
