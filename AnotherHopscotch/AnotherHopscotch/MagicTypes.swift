//
//  MagicTypes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

enum MagicTypes: Hashable, Equatable {
    
    indirect case array(MagicTypes)//, dict(MagicTypes:MagicTypes)
    case int, float, str, bool, any, void, bigint
    
    indirect case tuple([MagicTypes])
    // indirect case function([MagicTypes], MagicTypes)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        
        // When the type is any, auto downcast
        case (.any, _): return true
        
        // Check indices of tuples to check for `any` downcasts. Because it is indirect.
        case let (.tuple(t1), .tuple(t2)): return t1 == t2
        case let (.array(t1), .array(t2)): return t1 == t2
        case (.void, .tuple([])), (.tuple([]), .void): return true
            
        default: break
        }
        return "\(lhs)" == "\(rhs)"
    }
    
    func firstString() -> String {
        switch self {
        case let .tuple(this):
            if this.isEmpty { return "void" }
            return "\(this[0])"
        default:
            return "\(self)"
        }
    }
}
