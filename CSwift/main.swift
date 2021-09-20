protocol Converter {
    func convert(code: String) -> String?
}

public class Logger {
    public static func debug(_ str: String) {
        print("[debug] " + str)
    }
}

public class CSwiftConverter: Converter {
    private let sourceHead: String =
        """
        #include <bits/stdc++.h>
        using namespace std;
        """
    
    public func convert(code: String) -> String? {
        Logger.debug(sourceHead)
        return sourceHead
    }
    
}


let _ = CSwiftConverter().convert(code: "AA")
