//
//  CSwiftCoreTest.swift
//  CSwiftTest
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import XCTest
import CSwiftCore

class CSwiftCoreTest: XCTestCase {
    private let testCases: [String: String] = [
        "" : "",
        "42" : "42;\n",
        "1+1" : "1 + 1;\n",
        "var a = 10" : "int a = 10;\n",
        "var value = 432" : "int value = 432;\n",
        "1 == 1" : "1 == 1;\n",
        "var a = 10 / 2" : "int a = 10 / 2;\n",
        "var flag = true" : "int flag = true;\n",
        "let a=N*N" : "const int a = N * N;\n",
        "var num = (1 == 1)" : "int num = (1 == 1);\n",
        "var value=10" : "int value = 10;\n",
        "var flag=n==3" : "int flag = n == 3;\n",
        "print(n)" : "cout << n << endl;\n",
        "var a = 10\nprint(a)\n" : "int a = 10;\ncout << a << endl;\n",
        "input(n)\nprint(n)\n" : "int n;\ncin >> n;\ncout << n << endl;\n",
        "input(n, k)\nprint(n, k)\n" : "int n, k;\ncin >> n >> k;\ncout << n << \" \" << k << endl;\n",
        "if true {\n}\n" : "if (true) {\n}\n",
        "if true { }\n" : "if (true) {\n}\n",
        "if true { }\nvar a = 10\n" : "if (true) {\n}\nint a = 10;\n",
        "if true {\nvar a = 10\n}\n" : "if (true) {\nint a = 10;\n}\n",
        "if i < n {\n}\n" : "if (i < n) {\n}\n",
        "if i < n \n{\n}\n" : "if (i < n) {\n}\n",
        "i <= n" : "i <= n;\n",
    ]
    
    func testAll() throws {
        for (input, expected) in testCases {
            assertCSwiftConverter(input: input, expected: outputCode(cSource: expected))
        }
    }
    
    private func assertCSwiftConverter(input: String, expected: String) {
        guard let output = CSwiftConverter().convert(input: input) else {
            XCTFail("Failed to convert swift code: \(input)")
            return
        }
        
        XCTAssertEqual(output, expected, "\ninput: \n\(input)")
    }

    private func outputCode(cSource: String) -> String {
        var result: String =
        """
        #include <bits/stdc++.h>
        using namespace std;
        int main() {
        
        """
        
        result += cSource
        
        result += "}\n"
        
        return result
    }
}
