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
        source.appendLine(line: "    cout << \"Hello world!\" << endl;")
        source.appendLine(line: "}")
        
        Logger.debug(source.output(), type: .code)
        return source.output()
    }
    
}
