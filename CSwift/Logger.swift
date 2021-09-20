//
//  Logger.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import Foundation

class Logger {
    enum DebugType {
        case none
        case code
    }
    
    static func debug(_ str: String, type: DebugType = .none) {
        switch type {
        case .code:
            print("[debug] Code output:")
            print("--------------- Output code ---------------")
            print(str, terminator: "")
            print("------------------- End -------------------")
        default:
            print("[debug] " + str)
        }
    }
}
