//
//  Converter.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

protocol Converter {
    
    func convert(input: String) -> String?
    
}

public class CSwiftConverter: Converter {
    
    public init() {}
    
    public func convert(input: String) -> String? {
        let source = CSource()
        source.appendLine(line: "int main() {")
        
        // Convert swift code to cpp
        source.appendLines(lines: swiftToC(input: input))
        
        source.appendLine(line: "}")
        
        Logger.debug(source.output(), type: .code)
        return source.output()
    }
    
    private func swiftToC(input: String) -> [String]? {
        let tokens = SwiftTokenizer().tokenize(input: input)!
        
        return CSwiftParser().parse(tokens: tokens)!
    }
    
}
