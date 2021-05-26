//
//  Equating.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation

func ==<T>(lhs: Value, rhs: T) -> Bool {
    return "\(lhs.value)" == "\(rhs)"
}

//func ==<T>(lhs: Value, rhs: T) -> Bool {
//    return "\(type(of: lhs.value))" == "\(type(of: rhs))" && "\(lhs.value)" == "\(rhs)"
//}
