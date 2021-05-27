//
//  ScriptLibrary.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation
import BigInt
import MasterKit

extension Array {
    func turnToString() -> String {
        return "[" + self.reduce("") { $0 + "\($1)" + "," } + "]"
    }
}

func determineMagicType(_ from: Any) -> MagicTypes {
    switch from {
    case is Void: return .void
    case is Int: return .int
    case is BigInt: return .bigint
    case is String: return .str
    case is Double: return .float
    case is Bool: return .bool
    case is Array<Any>:
        if let foo = (from as! Array<Any>).first {
            return .array(determineMagicType(foo))
        } else {
            return .array(.any)
        }
    
    case is (Any, Any):
        let foo = (from as! (Any, Any))
        return .tuple([determineMagicType(foo.0), determineMagicType(foo.1)])
        
    case is (Any, Any, Any):
        let foo = (from as! (Any, Any, Any))
        return .tuple([determineMagicType(foo.0), determineMagicType(foo.1), determineMagicType(foo.1)])
        
    default:
        //if "\(type(of: from))".matches(<#T##the: String##String#>)
        
        
        fatalError()
    
    }
}

struct Precompile {
    
    static func go() {
        preProgram.run()
    }
    
    static var preProgram: [StackCode] = [
        
        // SET FUNCTION
//        .functionWithParams(name: "set", parameters: .any, returnType: .int, code: { param in [
//            .program({ Main.values["\(param[0])"] = Value.init(determineMagicType(param[1]), param[1]) }),
//        ]}),
        
        // GET
        .functionWithParams(name: "get", parameters: .any, returnType: .any, code: { param in [
            .literal(Main.values["\(param[0])"] ?? Value(.str, "<None>"))
        ]}),
        
        // Add Function
        .functionWithParams(name: "add", parameters: .tuple([.array(.any), .array(.any)]), returnType: .array(.any), code: { param in [
            .literal(Value(.array(.any), (param[0] as! Array<Any>) + (param[1] as! Array<Any>))),
        ]}),
        
        
        // Add Function
        .functionWithParams(name: "equals", parameters: .tuple([.any, .any]), returnType: .bool, code: { param in [
            .literal(Value(.bool, ((Value(.any, param[0]) == (param[1]))))),
        ]}),
        
        .functionWithParams(name: "range", parameters: .tuple([.int, .int]), returnType: .array(.int), code: { param in [
            .literal(Value(.array(.int), Array(int(param[0])...int(param[1])))),
        ]}),
        
        
        
        .functionWithParams(name: "array", parameters: .array(.any), returnType: .array(.any), code: { param in [
            .literal(Value(.array(.str), param)),
        ]}),
        .functionWithParams(name: "arrayint", parameters: .any, returnType: .array(.int), code: { param in [
            .literal(Value(.array(.int), Array<Int>(param.turnToString()) ?? [])),
        ]}),
        .functionWithParams(name: "arraybigint", parameters: .any, returnType: .array(.bigint), code: { param in [
            .literal(Value(.array(.bigint), (Array<Int>(param.turnToString()) ?? []).map { BigInt($0) })),
        ]}),
        
        
        
        
        // Sum Function
        .functionWithParams(name: "sum", parameters: .array(.int), returnType: .int, code: { param in [
            .literal(Value(.int, (param[0] as! [Int]).reduce(0, { $0 + int($1) }) )),
        ]}),
        // Product function
        .functionWithParams(name: "prod", parameters: .array(.int), returnType: .int, code: { param in [
            .literal(Value(.int, (param[0] as! [Int]).reduce(1, { $0 * int($1) }) )),
        ]}),
        // Product function
        .functionWithParams(name: "bigprod", parameters: .array(.int), returnType: .int, code: { param in [
            .literal(Value(.bigint, (param[0] as! [Int]).reduce(BigInt(1), { $0 * BigInt(int($1)) }) )),
        ]}),
        .functionWithParams(name: "bigprod", parameters: .array(.bigint), returnType: .int, code: { param in [
            .literal(Value(.bigint, (param[0] as! [BigInt]).reduce(BigInt(1), { $0 * (($1)) }) )),
        ]}),
        
        // Len Function
        .functionWithParams(name: "len", parameters: .array(.any), returnType: .int, code: { param in [
            .literal(Value(.int, (param[0] as! [Any]).count )),
        ]}),
        
        // Print Function
        .functionWithParams(name: "print", parameters: .any, returnType: .void, code: { param in [
            .program({ magicPrint(param) }),
        ]}),
        
    ]

    
}
