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
        // Convert swift code to cpp
        source.appendLines(lines: convertCode(input: "func main() {" + input + "}"))
        return source.output()
    }
    
    private func convertCode(input: String) -> [String]? {
        guard let tokens: [Token] = SwiftTokenizer().tokenize(input: input) else {
            Logger.error("Failed to tokenize input: \(input)")
        }
        guard let result: [String] = CSwiftParser().parseTokens(tokens) else {
            Logger.error("Failed to parse tokens: \(tokens)")
        }

        return result
    }
}
