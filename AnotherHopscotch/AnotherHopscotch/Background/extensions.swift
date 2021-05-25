//
//  extensions.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import SpriteKit

extension CGSize {
    func padding(_ this: CGFloat = 20) -> Self {
        return .init(width: width + this, height: height + this)
    }
}
extension CGPoint {
    mutating func minusPadding() {
        x -= 10; y -= 10
    }
}
extension CGFloat {
    mutating func indent(_ n: Int) {
        self += CGFloat(n) * 100
    }
}

extension String {
    func color() -> NSColor {
        switch self {
        case "var": return .init(red: 220.0/255.0, green: 194.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        case "if","else","elif": return .init(red: 71.0/255.0, green: 174.0/255.0, blue: 1.0, alpha: 1.0)
        default: return .black
        }
    }
}
