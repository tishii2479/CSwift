//
//  Extension.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

extension String {
    // TODO: remove
    var isOperator: Token.Kind? {
        for op in Token.Kind.operators {
            if self == op.rawValue {
                return op
            }
        }
        return nil
    }
}
