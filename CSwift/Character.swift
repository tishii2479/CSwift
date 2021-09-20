//
//  Character.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

extension Character {
    var isOperator: Bool {
        let ops = "+-*/="
        for op in ops {
            if self == op {
                return true
            }
        }
        return false
    }
}
