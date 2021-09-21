//
//  CSource.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

protocol Source {
    func appendLine(line: String)
    func output() -> String
}

class CSource {
    private let sourceHead: [String] =
        [
            "#include <bits/stdc++.h>",
            "using namespace std;"
        ]
    
    private var source: [String] = []
    
    init() {
        source = sourceHead
    }
    
    func appendLine(line: String?) {
        guard let line = line else { return }
        source.append(line)
    }
    
    func appendLines(lines: [String]?) {
        guard let lines = lines else { return }
        for line in lines {
            appendLine(line: line)
        }
    }
    
    func output() -> String {
        let result: String = source.joined(separator: "\n") + "\n"
        
        return result
    }
}
