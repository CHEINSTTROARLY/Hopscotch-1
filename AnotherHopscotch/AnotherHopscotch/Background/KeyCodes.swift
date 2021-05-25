//
//  KeyCodes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import SpriteKit

extension NSEvent {
    static var keyStrings: [String] = ["a","s","d","f","h","g","z","x","c","v","","b","q","w","e","r","y","t","1","2","3","4","6","5","=","9","7","-","8","0","]","o","u","[","i","p","","l","j","'","k",";","\\",",","/","n","m",".",""," ","`"]
    enum KeyCodes: Int {
        //case tab = 48
        //case q = 12
        case leftArrow = 123
        case rightArrow = 124
        case upArrow = 126
        case downArrow = 125
        case delete = 51
    }
    func tappedKey(_ n: KeyCodes) -> Bool {
        return keyCode == n.rawValue
    }
    func keyString() -> String {
        if self.keyCode > 50 { return "" }
        return Self.keyStrings[Int(self.keyCode)]
    }
}
extension Set where Element == Int {
    func holdingKeys(_ these: [NSEvent.KeyCodes]) -> Bool {
        return self.intersection(these.map { $0.rawValue }).count == these.count
    }
}

