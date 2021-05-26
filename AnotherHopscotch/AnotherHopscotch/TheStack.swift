//
//  TheStack.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

typealias FunctionType = (parameters: MagicTypes, returnType: MagicTypes, code: ([Any]) -> [StackCode] )
//typealias ValueType = (typeOf: MagicTypes, value: Any)

class Main {
    static var customFunctions: [String:[SuperEnumCompile]] = [:]
    static var functions: [String:[FunctionType]] = [:]
    static var values: [String:Value] = [:]
    
    // Find a given function
    static func findFunction(name: String, paramType: MagicTypes) -> FunctionType? {
        return functions[name]?.first(where: { $0.parameters == paramType })
    }
    
    static func getValue(name: String) -> Value? {
        return values[name]
    }
    static func editValue(name: String, setTo: Any) {
        values[name]?.value = setTo
    }
}
