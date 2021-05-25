//
//  KeyCodes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import SpriteKit

extension NSEvent {
    enum KeyCodes: Int {
        case tab = 48
        case q = 12
        case upArrow = 126
        case downArrow = 125
    }
    func tappedKey(_ n: KeyCodes) -> Bool {
        return keyCode == n.rawValue
    }
}
extension Set where Element == Int {
    func holdingKeys(_ these: [NSEvent.KeyCodes]) -> Bool {
        return self.intersection(these.map { $0.rawValue }).count == these.count
    }
}
