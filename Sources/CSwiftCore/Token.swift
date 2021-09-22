//
//  Token.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

struct Token: Convertable {
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
        case int
        case lShift     = "<<"
        case rShift     = ">>"
        case cName      // cin, cout
        case space      = "\" \""
        case less       = "<"
        case more       = ">"
        case lessEqual  = "<="
        case moreEqual  = ">="
        
        static let operators: [Kind] = [
            .plus, .minus, .mul, .div, .equal, .assign, .less, .more,
            .lessEqual, .moreEqual
        ]
        
        static let reserved: [Kind] = [
            .if, .var, .let, .true, .false, .print, .input
        ]
        
        var noLeftSpace: Bool {
            [.comma, .rBr, .rBrCur].contains(self)
        }
        
        var noRightSpace: Bool {
            [.lBr, .lBrCur].contains(self)
        }
        
        var isOperator: Bool {
            Token.Kind.operators.contains(self)
        }
        
        var isCustomStr: Bool {
            [.num, .variable, .cName].contains(self)
        }
                
        func isConvertable(_ str: String) -> Bool {
            switch self {
            case .num:
                if let _ = Int(str) {
                    return true
                }
                return false
            case .variable:
                return str.first?.isLetter == true
            default:
                return str == self.rawValue
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
        case .num, .variable, .cName:
            return str
        default:
            return kind.rawValue
        }
    }
    
    static func reservedToken(_ str: String) -> Token? {
        for kind in Kind.reserved {
            if kind.isConvertable(str) {
                return Token(kind: kind)
            }
        }
        return nil
    }
    
    static func convertToken(_ str: String) -> Token? {
        for kind in Kind.allCases {
            if kind.isConvertable(str) {
                return Token(kind: kind, str: str)
            }
        }
        return nil
    }
    
    init(kind: Kind, str: String) {
        self.kind = kind
        self.str = str
    }
    
    init(kind: Kind) {
        if kind.isCustomStr {
            Logger.debug("\(kind) is not a custom str.", type: .warn)
        }
        
        self.kind = kind
        self.str = kind.rawValue
    }
}
