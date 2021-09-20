//
//  CSwiftTest.swift
//  CSwiftTest
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import XCTest
import CSwift

class CSwiftTest: XCTestCase {
    private let testCases: [String: String] = [
        "" : "",
        "42" : "42;\n",
        "1+1" : "1 + 1;\n",
        "var a = 10" : "auto a = 10;\n",
        "var value = 432" : "auto value = 432;\n",
        "1 == 1" : "1 == 1;\n",
        "var a = 10 / 2" : "auto a = 10 / 2;\n",
        "var flag = true" : "auto flag = true;\n",
        "let a=N*N" : "const auto a = N * N;\n",
        "var num = (1 == 1)" : "auto num = ( 1 == 1 );\n",
        "var value=10" : "auto value = 10;\n",
        "var flag=n==3" : "auto flag = n == 3;\n",
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
        
        XCTAssertEqual(output, expected)
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
