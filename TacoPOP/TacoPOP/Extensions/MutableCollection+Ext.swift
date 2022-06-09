//
//  MutableCollection+Ext.swift
//  TacoPOP
//
//  Created by Maury on 7/06/22.
//

import Foundation

extension MutableCollection where Index == Int {
    mutating func shuffle1() {
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            self.swapAt(i, j)
        }
    }
}
