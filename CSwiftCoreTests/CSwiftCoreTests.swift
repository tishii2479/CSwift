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
        "var a = 10" : "int a = 10;\n",
        "var value = 432" : "int value = 432;\n",
        "var a = 10 / 2" : "int a = 10 / 2;\n",
        "var flag = true" : "int flag = true;\n",
        "let a=N*N" : "const int a = N * N;\n",
        "var num = 1 == 1" : "int num = 1 == 1;\n",
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
        "func f () {\n}\n" : "int f () {\n}\n",
        "func f () { var a = 10\n }" : "int f () {\nint a = 10;\n}\n",
        "func f () { var a = 10 }" : "int f () {\nint a = 10;\n}\n",
        "if i == n { } else if j <= n { } else { }" : "if (i == n) {\n}\nelse if (j <= n) {\n}\nelse {\n}\n",
        "if true { if false { } }" : "if (true) {\nif (false) {\n}\n}\n",
        "if true { if true { if true { } else { } } }" : "if (true) {\nif (true) {\nif (true) {\n}\nelse {\n}\n}\n}\n",
        "var a = 10 a = a * 10" : "int a = 10;\na = a * 10;\n",
    ]
    
    func testAll() throws {
        for (input, expected) in testCases {
            assertCSwiftConverter(input: input, expected: outputCode(cSource: expected))
        }
    }
    
    private func assertCSwiftConverter(input: String, expected: String) {
        Logger.debug("Testing... \n\(input)")
        guard let output = CSwiftConverter().convert(input: input) else {
            XCTFail("Failed to convert swift code: \(input)")
            return
        }
        Logger.debug("Output: \n\(output)")
        XCTAssertEqual(output, expected, "\ninput: \n\(input)")
    }

    private func outputCode(cSource: String) -> String {
        var result: String =
        """
        #include <bits/stdc++.h>
        using namespace std;
        int main () {
        
        """
        
        result += cSource
        
        result += "}\n"
        
        return result
    }
}
