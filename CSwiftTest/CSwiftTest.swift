//
//  CSwiftTest.swift
//  CSwiftTest
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import XCTest
import CSwift

class CSwiftTest: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        let expected: String = 
        """
        #include <bits/stdc++.h>
        using namespace std;
        int main() {
            cout << "Hello world!" << endl;
        }
        
        """
        XCTAssertEqual(CSwiftConverter().convert(input: "")!, expected)
    }

    func testPerformanceExample() throws {
//        measure {
//            
//        }
    }

}
