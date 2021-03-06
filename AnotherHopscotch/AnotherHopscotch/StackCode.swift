//
//  StackCode.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

//enum BuiltInFunctions: String {
//    case print, add, sum, triangle, len, int, str, neg, sub, times, div
//}

indirect enum StackCode {

    // Keep #1
    case getValue(name: String)
    
    // Keep #2?
    case functionWithParams(name: String, parameters: MagicTypes, returnType: MagicTypes, code: ([Any]) -> [StackCode])
    case goToFunction(name: String, parameters: [StackCode])
    
    // KEEP #3!?
    case literal(Value)// (MagicTypes, Any)
    //case literal(Value)
    case program(() -> ())
}

extension Array where Element == StackCode {
    
    @discardableResult
    func run() -> Value {
        for line in self {
            
            switch line {
            
            // CREATE A VALUE
//            case let .createValue(name: nam, setTo: set):
//                Main.values[nam] = set.run()
            
            case let.program(foo): foo()
            
            case let .literal(val):
                return val
                
            // RECIEVE A VALUE
            case let .getValue(name: nam):
                if let foo = Main.getValue(name: nam) {
                    return foo
                }
                fatalError("Could not find value: \(nam)")
                
            case let .functionWithParams(name: nam, parameters: param, returnType: ret, code: code):
                
                if Main.functions[nam] == nil {
                    Main.functions[nam] = []
                }
                
                if Main.functions[nam]?.contains(where: { $0.parameters == param }) == true {
                    fatalError("Oops, There is already a function with that name with matching parameters!")
                }
                
                Main.functions[nam]?.append((param, ret, code))
                
            case let .goToFunction(name: nam, parameters: param):
                
                let realStuff = param.map { [$0].run() }
                
                
                let willItBeTuple = realStuff.map { $0.magicType }
                var givenParamType = MagicTypes.tuple(realStuff.map { $0.magicType })
                if willItBeTuple.count == 1 {
                    givenParamType = willItBeTuple[0]
                }
                let results = realStuff.map { $0.value }
                
                if nam == "set" {
                    realStuff[0].value = realStuff[1].value // class mobile code ;)
                    
                } else if let foo = Main.structures[givenParamType.firstString()], nam.hasPrefix("$"), case var n = nam {
                    n.removeFirst()
                    return realStuff[0].storedValues[n] ?? Value(.void, ())
                } else if let found = Main.findFunction(name: nam, paramType: givenParamType) {
                    
                    if found.parameters != givenParamType {
                        print("Expected Parameters \(found.parameters). Instead, recieved: \(givenParamType)")
                        fatalError()
                        
                    } else {
                        let params = results
                        
                        let result = found.code(params).run()
                        //print("---,", result)
                        if result.magicType != .void {
                            return result
                        } else if "\(result.magicType)" == "any" {
                            return result
                        }
                    }
                } else {
                    var oo = 0
                    for i in param {
                        Main.values[String(oo)] = [i].run()
                        oo += 1
                    }
                    
                    // Double check if the `.` was for a float literal like 1.0
                    let testForFloat = "\(param.run().value)" + "." + nam
                    if let fl = Double(testForFloat) {
                        return Value(.float, fl)
                    }
                    
                    return Main.customFunctions[nam]?.runEnum().returnedValue ?? Value(.void, ())
                }
                
            }
            
        }
        
        return Value(.void, ())
    }
}
