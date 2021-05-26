//
//  Value.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

class Value: CustomStringConvertible {
    var description: String {
        return "Value: \(self.magicType) = \(self.value)"
    }
    
    var magicType: MagicTypes
    var value: Any
    init(_ theType: MagicTypes,_ some: Any) {
        magicType = theType
        value = some
    }
}
