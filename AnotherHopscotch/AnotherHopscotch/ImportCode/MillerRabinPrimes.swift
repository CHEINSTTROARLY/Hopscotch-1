//
//  MillerRabinPrimes.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/26/21.
//

import Foundation
import BigInt

struct Prime {
    static func isPrime(n: BigInt) -> Bool {
        return n.isPrime(rounds: 1)
    }
    
    static func inverse_number(_ i: BigInt) -> BigInt {
        let inverse = "\(i)".reversed().reduce("") { $0 + String($1) }
        return BigInt(inverse) ?? .zero
    }
    static func inverse_number(_ i: Int) -> Int {
        let inverse = "\(i)".reversed().reduce("") { $0 + String($1) }
        return Int.init(inverse) ?? .zero
    }
    
    
    static func turn_into_palindrome(_ i: BigInt) -> BigInt {
        var stringo = String(i)
        stringo.removeLast()
        return BigInt.init(stringo + String(inverse_number(i)))!
    }
    static func turn_into_palindrome(_ i: Int) -> Int {
        var stringo = String(i)
        stringo.removeLast()
        return Int.init(stringo + String(inverse_number(i)))!
    }
    
    //static func randomPrime()
    
}
