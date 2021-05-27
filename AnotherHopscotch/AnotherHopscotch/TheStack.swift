//
//  TheStack.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

typealias FunctionType = (parameters: MagicTypes, returnType: MagicTypes, code: ([Any]) -> [StackCode] )
//typealias ValueType = (typeOf: MagicTypes, value: Any)


struct CustomStructType {
    var name: String
    var functions: [String:FunctionType] = [:]
    var values: [String:Value] = [:]
    var initializer: FunctionType
    
    static let prebuiltObjects: [String:CustomStructType] = [
        "int": CustomStructType(
            name: "int",
            functions: [
                "add":(parameters: .tuple([.int, .int]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) + int(param[1]))))]
                }),
                "sub":(parameters: .tuple([.int, .int]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) - int(param[1]))))]
                }),
                "times":(parameters: .tuple([.int, .int]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) * int(param[1]))))]
                }),
                "div":(parameters: .tuple([.int, .int]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) / int(param[1]))))]
                }),
                "inc":(parameters: .int, returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) + 1)))]
                })
            ],
            values: [:],
            initializer: // Int Function
                (parameters: .any, returnType: .int, code: { param in [
                    .literal(Value(.int, Int("\(param[0])") ?? 0)),
                ]})
        )
    
    ]
}


class Main {
    static func reset() {
        Main.structures = CustomStructType.prebuiltObjects
        Main.customFunctions = [:]
        Main.functions = [:]
        Main.values = [:]
    }
    
    static var structures: [String:CustomStructType] = CustomStructType.prebuiltObjects
    static var customFunctions: [String:[SuperEnumCompile]] = [:]
    static var functions: [String:[FunctionType]] = [:]
    static var values: [String:Value] = [:]
    
    // Find a given function
    static func findFunction(name: String, paramType: MagicTypes) -> FunctionType? {
        if let foo = structures[name] {
            return foo.initializer
        } else if let foo = structures[paramType.firstString()]?.functions[name] {
            return foo
        }
        
        return functions[name]?.first(where: { $0.parameters == paramType })
    }
    
    static func getValue(name: String) -> Value? {
        return values[name]
    }
    
    static func editValue(name: String, setTo: Any) {
        values[name]?.value = setTo
    }
}


//class Main {
//    static var customFunctions: [String:[SuperEnumCompile]] {
//        get { o.customFunctions }
//        set { o.customFunctions = newValue }
//    }
//    static var functions: [String:[FunctionType]] {
//        get { o.functions }
//        set { o.functions = newValue }
//    }
//    static var values: [String:Value] {
//        get { o.values }
//        set { o.values = newValue }
//    }
//
//    private static var o = Main()
//
//    var customFunctions: [String:[SuperEnumCompile]] = [:]
//    var functions: [String:[FunctionType]] = [:]
//    var values: [String:Value] = [:]
//
//    // Find a given function
//    static func findFunction(name: String, paramType: MagicTypes) -> FunctionType? {
//        return o.findFunction(name: name, paramType: paramType)
//    }
//    func findFunction(name: String, paramType: MagicTypes) -> FunctionType? {
//        return functions[name]?.first(where: { $0.parameters == paramType })
//    }
//
//    static func getValue(name: String) -> Value? {
//        return o.getValue(name: name)
//    }
//    func getValue(name: String) -> Value? {
//        return values[name]
//    }
//
//    static func editValue(name: String, setTo: Any) {
//        o.editValue(name: name, setTo: setTo)
//    }
//    func editValue(name: String, setTo: Any) {
//        values[name]?.value = setTo
//    }
//}
