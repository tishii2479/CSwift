//
//  Formatter.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/10/08.
//

import Foundation

protocol Formatter {
    func format(code: [String]) -> [String]
}

class CSwiftFormatter: Formatter {
    func format(code: [String]) -> [String] {
        let indentSize: Int = 4
        var indentCount: Int = 0
        var result: [String] = []
        
        for line in code {
            var count: Int = 0
            for c in line {
                if c == "{" {
                    count += 1
                } else if c == "}" {
                    count -= 1
                }
            }
            if count < 0 {
                indentCount += count
                result.append(String(repeating: " ", count: indentSize * indentCount) + line)
            } else if count > 0 {
                result.append(String(repeating: " ", count: indentSize * indentCount) + line)
                indentCount += count
            } else {
                result.append(String(repeating: " ", count: indentSize * indentCount) + line)
                indentCount += count
            }
        }
        
        return result
    }
}
