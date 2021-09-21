//
//  Node.swift
//  CSwift
//
//  Created by Tatsuya Ishii on 2021/09/21.
//

import Foundation

protocol Node {
    var convertValue: String { get }
    mutating func appendToken(_ token: Token)
}
