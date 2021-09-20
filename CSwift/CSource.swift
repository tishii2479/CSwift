//
//  CSource.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

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
        for head in sourceHead {
            source.append(head)
        }
    }
    
    func appendLine(line: String) {
        source.append(line)
    }
    
    func output() -> String {
        var result: String = ""
        
        for line in source {
            result.append(line + "\n")
        }
        
        return result
    }
    
}
