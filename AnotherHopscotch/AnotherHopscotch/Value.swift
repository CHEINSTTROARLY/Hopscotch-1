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
    
    //var structType: CustomStructType
    var storedValues: [String:Value]
    var magicType: MagicTypes
    var value: Any
    init(_ theType: MagicTypes,_ some: Any) {
        magicType = theType
        value = some
        //self.structType = structType
        
        storedValues = Main.structures["\(theType)"]?.values.reduce([String:Value]()) {
            var i = $0
            i[$1.key] = $1.value()
            return i
        } ?? [:]
        
        //storedValues = Main.structures["\(theType)"]?.values ?? [:]
    }
}
