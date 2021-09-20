//
//  main.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

let input: String =
"""
if true {
    
}

"""
if let result = CSwiftConverter().convert(input: input) {
    Logger.debug(result, type: .code)
}
else {
    Logger.error("Failed to convert input: \(input)")
}
