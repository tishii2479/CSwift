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
    
    enum ErrorType {
        case error
        case warning
    }
    
    static func debug(_ val: Any..., type: DebugType = .none) {
        switch type {
        case .code:
            print("[debug] Code output:")
            print("--------------- Output code ---------------")
            for v in val {
                print(v)
            }
            print("------------------- End -------------------")
        case .none:
            print("[debug] ", terminator: "")
            for v in val {
                print(v, terminator: " ")
            }
            print("")
        }
    }
    
    static func error(_ val: Any..., type: ErrorType = .error) {
        switch type {
        case .error:
            print("[error] ", terminator: "")
            for v in val {
                print(v, terminator: " ")
            }
            print("")
            fatalError()
        case .warning:
            print("[warning] ", terminator: "")
            for v in val {
                print(v, terminator: " ")
            }
            print("")
        }
    }
}
