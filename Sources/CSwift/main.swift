//
//  main.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/20.
//

import CSwiftCore
import ArgumentParser
import Foundation

struct Main: ParsableCommand {
    @Argument(help: "Swift file name to convert.")
    var inputFile: String?
    
    @Option(name: [.customLong("output"), .customShort("o")], help: "Cpp file name to output result.")
    var outputFile: String?

    mutating func run() throws {
        guard let inputFile = inputFile else {
            Logger.error("Input file '\(self.inputFile)' does not exist")
            return
        }
        
        let inputURL = URL(fileURLWithPath: inputFile)
        let outputURL = URL(fileURLWithPath: outputFile ?? "out.cpp")

        do {
            let input = try String(contentsOf: inputURL)
            if let result = CSwiftConverter().convert(input: input) {
                Logger.debug(result, type: .code)
                try result.write(to: outputURL, atomically: true, encoding: .utf8)
                Logger.debug("Finished writing to file: \(outputURL)")
            }
            else {
                Logger.error("Failed to convert input: \(input)")
            }
        }
        catch {
            Logger.error("Failed to convert in some reason")
        }
    }
}

Main.main()
