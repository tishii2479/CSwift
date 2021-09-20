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
        "42" : "42\n",
        "1 + 1" : "1 + 1\n",
    ]
    
    func testAll() throws {
        for (input, expected) in testCases {
            assertCSSwiftConverter(input: input, expected: outputCode(cSource: expected))
        }
    }
    
    private func assertCSSwiftConverter(input: String, expected: String) {
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
