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
        "var a = 10" : "    int a = 10;\n",
        "var value = 432" : "    int value = 432;\n",
        "var a = 10 / 2" : "    int a = 10 / 2;\n",
        "var flag = true" : "    int flag = true;\n",
        "let a=N*N" : "    const int a = N * N;\n",
        "var num = 1 == 1" : "    int num = 1 == 1;\n",
        "var value=10" : "    int value = 10;\n",
        "var flag=n==3" : "    int flag = n == 3;\n",
        "print(n)" : "    cout << n << endl;\n",
        "var a = 10\nprint(a)\n" : "    int a = 10;\n    cout << a << endl;\n",
        "var n = 0\ninput(n)\nprint(n)\n" : "    int n = 0;\n    cin >> n;\n    cout << n << endl;\n",
        "var n = 0\nvar k = 0\ninput(n, k)\nprint(n, k)\n" : "    int n = 0;\n    int k = 0;\n    cin >> n >> k;\n    cout << n << \" \" << k << endl;\n",
        "if true {\n}\n" : "    if (true) {\n    }\n",
        "if true { }\n" : "    if (true) {\n    }\n",
        "if true { }\nvar a = 10\n" : "    if (true) {\n    }\n    int a = 10;\n",
        "if true {\nvar a = 10\n}\n" : "    if (true) {\n        int a = 10;\n    }\n",
        "if i < n {\n}\n" : "    if (i < n) {\n    }\n",
        "func f () {\n}\n" : "    int f () {\n    }\n",
        "func f () { var a = 10\n }" : "    int f () {\n        int a = 10;\n    }\n",
        "if i == n { } else if j <= n { } else { }" : "    if (i == n) {\n    }\n    else if (j <= n) {\n    }\n    else {\n    }\n",
        "if true { if false { } }" : "    if (true) {\n        if (false) {\n        }\n    }\n",
        "if true { if true { if true { } else { } } }" : "    if (true) {\n        if (true) {\n            if (true) {\n            }\n            else {\n            }\n        }\n    }\n",
        "var a = 10 a = a * 10" : "    int a = 10;\n    a = a * 10;\n",
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
