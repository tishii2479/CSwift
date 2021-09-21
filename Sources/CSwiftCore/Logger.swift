//
//  Logger.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

public class Logger {
    public enum DebugType {
        case none
        case code
    }
    
    public static func debug(_ val: Any..., type: DebugType = .none) {
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
    
    public static func error(_ val: Any...) -> Never {
        print("[error] ", terminator: "")
        for v in val {
            print(v, terminator: " ")
        }
        print("")
        
        fatalError()
    }
}
