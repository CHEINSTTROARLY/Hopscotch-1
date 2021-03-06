//
//  CustomStruct.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/27/21.
//

import Foundation
import BigInt

struct CustomStructType {
    var name: String
    var functions: [String:FunctionType] = [:]
    var values: [String:()->Value] = [:] // TODO: values (& static values?)
    var initializer: FunctionType
    
    static let prebuiltObjects: [String:CustomStructType] = [
        
        // Int Object
        "int": CustomStructType(
            name: "int",
            functions: [
                "add":(parameters: .tuple([.int, .any]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) + int(param[1]))))]
                }),
                "sub":(parameters: .tuple([.int, .any]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) - int(param[1]))))]
                }),
                "times":(parameters: .tuple([.int, .any]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) * int(param[1]))))]
                }),
                "div":(parameters: .tuple([.int, .any]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) / int(param[1]))))]
                }),
                "inc":(parameters: .int, returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) + 1)))]
                }),
                "neg":(parameters: .int, returnType: .int, code: { param in [
                    .literal(Value(.int, -int(param[0]))),
                ]}),
                "rev":(parameters: .int, returnType: .int, code: { param in [
                    .literal(Value(.int, Prime.inverse_number(int(param[0])))),
                ]}),
                "mod":(parameters: .tuple([.int, .any]), returnType: .int, code: { param in
                    return [.literal(Value(.int, (int(param[0]) % int(param[1]))))]
                }),
                "pow":(parameters: .tuple([.int, .any]), returnType: .int, code: { param in
                    return [.literal(Value(.int, Int(pow(Double(int(param[0])), Double(int(param[1]))))))]
                }),
                "palin":(parameters: .int, returnType: .int, code: { param in [
                    .literal(Value(.int, Prime.turn_into_palindrome(int(param[0])))),
                ]}),
                "triangle":(parameters: .int, returnType: .array(.int), code: { param in [
                    .literal(Value(.array(.int), Array(1...int(param[0]))))
                ]}),
            ],
            values: [
                "foo":{Value(.bool, true)}
            ],
            initializer: // Int Function
                (parameters: .any, returnType: .int, code: { param in [
                    .literal(Value(.int, Int("\(param[0])") ?? 0)),
                ]})
        ),
        
        // Float Object
        "float": CustomStructType(
            name: "float",
            functions: [
                "add":(parameters: .tuple([.float, .any]), returnType: .float, code: { param in
                    return [.literal(Value(.float, (float(param[0]) + float(param[1]))))]
                }),
                "sub":(parameters: .tuple([.float, .any]), returnType: .float, code: { param in
                    return [.literal(Value(.float, (float(param[0]) - float(param[1]))))]
                }),
                "times":(parameters: .tuple([.float, .any]), returnType: .float, code: { param in
                    return [.literal(Value(.float, (float(param[0]) * float(param[1]))))]
                }),
                "div":(parameters: .tuple([.float, .any]), returnType: .float, code: { param in
                    return [.literal(Value(.float, (float(param[0]) / float(param[1]))))]
                }),
                "mod":(parameters: .tuple([.float, .any]), returnType: .float, code: { param in
                    return [.literal(Value(.float, (float(param[0]).truncatingRemainder(dividingBy: float(param[1])))))]
                }),
                "pow":(parameters: .tuple([.float, .any]), returnType: .float, code: { param in
                    return [.literal(Value(.float, (pow((float(param[0])), (float(param[1]))))))]
                }),
            ],
            values: [:],
            initializer: // Int Function
                (parameters: .any, returnType: .float, code: { param in [
                    .literal(Value(.float, Double("\(param[0])") ?? 0)),
                ]})
        ),
        
        // BigInt Object
        "bigint": CustomStructType(
            name: "bigint",
            functions: [
                "add":(parameters: .tuple([.bigint, .bigint]), returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, (param[0]as!BigInt) + (param[1]as!BigInt))),
                ]}),
                "sub":(parameters: .tuple([.bigint, .bigint]), returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, (param[0]as!BigInt) - (param[1]as!BigInt))),
                ]}),
                "times":(parameters: .tuple([.bigint, .bigint]), returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, (param[0]as!BigInt) * (param[1]as!BigInt))),
                ]}),
                "div":(parameters: .tuple([.bigint, .bigint]), returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, (param[0]as!BigInt) / (param[1]as!BigInt))),
                ]}),
                "mod":(parameters: .tuple([.bigint, .bigint]), returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, (param[0]as!BigInt) % (param[1]as!BigInt))),
                ]}),
                "pow":(parameters: .tuple([.bigint, .any]), returnType: .bigint, code: { param in
                    return [.literal(Value(.int, (param[0]as!BigInt).power(int(param[1]))))]
                }),
                "powm":(parameters: .tuple([.bigint, .bigint, .bigint]), returnType: .bigint, code: { param in
                    return [.literal(Value(.int, (param[0]as!BigInt).power(param[1]as!BigInt, modulus: param[2]as!BigInt)))]
                }),
                "prime":(parameters: .bigint, returnType: .bool, code: { param in [
                    .literal(Value(.bigint, Prime.isPrime(n: (param[0]as!BigInt)))),
                ]}),
                "palin":(parameters: .bigint, returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, Prime.turn_into_palindrome((param[0]as!BigInt)))),
                ]}),
                "rev":(parameters: .bigint, returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, Prime.inverse_number((param[0]as!BigInt)))),
                ]}),
                "nextprime":(parameters: .bigint, returnType: .bigint, code: { param in [
                    .literal(Value(.bigint, Prime.nextPrime(n: (param[0]as!BigInt)))),
                ]}),
                
            ],
            values: [:],
            initializer:
                (parameters: .any, returnType: .int, code: { param in [
                    .literal(Value(.bigint, BigInt("\(param[0])") ?? 0)),
                ]})
        ),
        
        
        // String Object
        "str": CustomStructType(
            name: "str",
            functions: [
                "add":(parameters: .tuple([.str, .str]), returnType: .str, code: { param in [
                    .literal(Value(.str, (param[0] as! String) + (param[1] as! String) )),
                ]}),
                "len":(parameters: .str, returnType: .int, code: { param in [
                    .literal(Value(.int, (param[0] as! String).count )),
                ]}),
                "count":(parameters: .str, returnType: .int, code: { param in [
                    .literal(Value(.int, (param[0] as! String).count )),
                ]}),
                "rev":(parameters: .str, returnType: .str, code: { param in [
                    .literal(Value(.str, (param[0] as! String).reversed().reduce("") { $0 + String($1) } )),
                ]}),
            ],
            values: [:],
            initializer:
                (parameters: .any, returnType: .str, code: { param in [
                    .literal(Value(.str, "\(param[0])")),
                ]})
        ),
        
        // String Object
        "bool": CustomStructType(
            name: "bool",
            functions: [
                "and":(parameters: .tuple([.bool, .bool]), returnType: .bool, code: { param in [
                    .literal(Value(.bool, (param[0] as! Bool) && (param[1] as! Bool) )),
                ]}),
                "or":(parameters: .tuple([.bool, .bool]), returnType: .bool, code: { param in [
                    .literal(Value(.bool, (param[0] as! Bool) || (param[1] as! Bool) )),
                ]}),
                "not":(parameters: .bool, returnType: .bool, code: { param in [
                    .literal(Value(.bool, !(param[0] as! Bool) )),
                ]}),
            ],
            values: [:],
            initializer:
                (parameters: .any, returnType: .bool, code: { param in [
                    .literal(Value(.bool, Bool.init("\(param[0])") ?? false)),
                ]})
        )
    
    ]
}
