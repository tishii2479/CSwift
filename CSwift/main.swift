//
//  main.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

let input: String = "var a = 10"
if let result = CSwiftConverter().convert(input: input) {
    print(result)
}
else {
    Logger.error("Failed to convert input: \(input)")
}
