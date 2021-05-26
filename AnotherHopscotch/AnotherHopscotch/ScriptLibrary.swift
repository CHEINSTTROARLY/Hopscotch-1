//
//  ScriptLibrary.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation


func determineMagicType(_ from: Any) -> MagicTypes {
    switch from {
    case is Void: return .void
    case is Int: return .int
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
        .functionWithParams(name: "set", parameters: .any, returnType: .int, code: { param in [
            .program({ Main.values["\(param[0])"] = Value.init(determineMagicType(param[1]), param[1]) }),
        ]}),
        
        // GET
        .functionWithParams(name: "get", parameters: .any, returnType: .any, code: { param in [
            .literal(Main.values["\(param[0])"] ?? Value(.str, "<None>"))
        ]}),
        
        
        // Int Function
        .functionWithParams(name: "int", parameters: .any, returnType: .int, code: { param in [
            .literal(Value(.int, Int("\(param[0])") ?? 0)),
        ]}),
        // Str Function
        .functionWithParams(name: "str", parameters: .any, returnType: .str, code: { param in [
            .literal(Value(.str, "\(param[0])")),
        ]}),
        
        // Add Function
        .functionWithParams(name: "add", parameters: .tuple([.int, .int]), returnType: .int, code: { param in [
            .literal(Value(.int, (int(param[0]) + int(param[1])))),
        ]}),
        // Add Function
        .functionWithParams(name: "add", parameters: .tuple([.str, .str]), returnType: .array(.any), code: { param in [
            .literal(Value(.array(.any), (param[0] as! String) + (param[1] as! String) )),
        ]}),
        // Add Function
        .functionWithParams(name: "add", parameters: .tuple([.array(.any), .array(.any)]), returnType: .array(.any), code: { param in [
            .literal(Value(.array(.any), (param[0] as! Array<Any>) + (param[1] as! Array<Any>))),
        ]}),
        
        
        // Add Function
        .functionWithParams(name: "equals", parameters: .tuple([.any, .any]), returnType: .bool, code: { param in [
            .literal(Value(.bool, ((Value(.any, param[0]) == (param[1]))))),
        ]}),
        
        // Neg Function
        .functionWithParams(name: "neg", parameters: .int, returnType: .int, code: { param in [
            .literal(Value(.int, -int(param[0]))),
        ]}),
        // Sub Function
    //    .functionWithParams(name: "sub", parameters: .tuple([.int, .int]), returnType: .int, code: { param in [
    //        ._run(.add, [.literal(.int, param[0]), ._run(.neg, [.literal(.int, param[1])])])
    //    ]}),
        .functionWithParams(name: "times", parameters: .tuple([.int, .int]), returnType: .int, code: { param in [
            .literal(Value(.int, (int(param[0]) * int(param[1])))),
        ]}),
        .functionWithParams(name: "div", parameters: .tuple([.int, .int]), returnType: .int, code: { param in [
            .literal(Value(.int, (int(param[0]) / int(param[1])))),
        ]}),
        
        
        // Sum Function
        .functionWithParams(name: "sum", parameters: .array(.int), returnType: .int, code: { param in [
            .literal(Value(.int, (param[0] as! [Int]).reduce(0, { $0 + int($1) }) )),
        ]}),
        
        // Len Function
        .functionWithParams(name: "len", parameters: .array(.any), returnType: .int, code: { param in [
            .literal(Value(.int, (param[0] as! [Any]).count )),
        ]}),
        // Len Function
        .functionWithParams(name: "len", parameters: .str, returnType: .int, code: { param in [
            .literal(Value(.int, (param[0] as! String).count )),
        ]}),
        
        
        // Triangle Number Function
        .functionWithParams(name: "triangle", parameters: .int, returnType: .array(.int), code: { param in [
            .literal(Value(.array(.int), Array(1...int(param[0]))))
        ]}),
        
        // Print Function
        .functionWithParams(name: "print", parameters: .any, returnType: .void, code: { param in [
            .program({ magicPrint(param) }),
        ]}),
        
    ]

    
}
