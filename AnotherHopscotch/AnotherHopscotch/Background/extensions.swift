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
