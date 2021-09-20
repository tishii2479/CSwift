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
        let code: String = ""
        XCTAssertEqual(CSwiftConverter().convert(code: code), "Hello world!")
    }

    func testPerformanceExample() throws {
//        measure {
//            
//        }
    }

}
