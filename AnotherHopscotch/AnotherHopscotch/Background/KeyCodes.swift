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
    static var shiftStrings: [String] = ["A","S","D","F","H","G","Z","X","C","V","","B","Q","W","E","R","Y","T","!","@","#","$","^","%","+","(","&","_","*",")","}","O","U","{","I","P","","L","J","\"","K",":","|","<","?","N","M",">",""," ","~"]
    static var optionStrings: [String] = ["å","ß","∂","ƒ","˙","©","Ω","≈","ç","√","","∫","œ","∑","´","®","¥","†","¡","™","£","¢","§","∞","≠","ª","¶","–","•","º","‘","ø","¨","“","ˆ","π","","¬","∆","«","˚","…","«","≤","÷","˜","µ","≥",""," ","`"]
    static var optionShiftStrings: [String] = ["Å","Í","Î","Ï","Ó","˝","¸","˛","Ç","◊","","ı","Œ","„","´","‰","Á","ˇ","⁄","€","‹","›","ﬂ","ﬁ","±","·","‡","—","°","‚","’","Ø","¨","”","ˆ","∏","","Ò","Ô","Æ","","Ú","»","¯","¿","˜","Â","˘",""," ","`"]
    
    enum KeyCodes: Int {
        //case tab = 48
        //case q = 12
        case leftArrow = 123
        case rightArrow = 124
        case upArrow = 126
        case downArrow = 125
        case delete = 51
        case spacebar = 49
    }
    func tappedKey(_ n: KeyCodes) -> Bool {
        return keyCode == n.rawValue
    }
    func keyString(_ modifierFlags: Modify) -> String {
        if self.keyCode > 50 { return "" }
        switch modifierFlags {
        case .none: return Self.keyStrings[Int(self.keyCode)]
        case .shift: return Self.shiftStrings[Int(self.keyCode)]
        case .option: return Self.optionStrings[Int(self.keyCode)]
        case .optionShift: return Self.optionShiftStrings[Int(self.keyCode)]
        }
    }
    enum Modify {
        case none, shift, option, optionShift
    }
}
extension Set where Element == Int {
    func holdingKeys(_ these: [NSEvent.KeyCodes]) -> Bool {
        return self.intersection(these.map { $0.rawValue }).count == these.count
    }
}

