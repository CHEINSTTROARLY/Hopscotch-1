//
//  Regex.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/25/21.
//

import Foundation


extension String {
    
    func matches(_ the: String) -> Bool {
        return the.replacingAll(matching: self, with: "") != the
    }
    
    func replacingAll(matching: String, with: Self) -> Self {
        return replacingOccurrences(of: matching, with: with, options: .regularExpression)
    }
    
    func replacingFirst(matching: String, with: Self) -> Self {
        if let range = range(of: matching, options: .regularExpression) {
            return self.replacingCharacters(in: range, with: with)
        }
        return self
    }


    func replacingMiddle(matching: String, with: Self) -> Self {
        let foo = self.indices1(of: matching)
        return self.replacingCharacters(in: foo[foo.count/2], with: with)
    }
    func splitMiddle(from: String) -> (Self, Self) {
        let foo = self.indices1(of: from)
        let wow = self.replacingCharacters(in: foo[foo.count/2], with: "|")
        let or1 = wow.split(separator: "|")
        return (String(or1[0]), String(or1[1]))
    }
    func splitFirst(from: String) -> (Self, Self) {
        let foo = self.indices1(of: from)
        let wow = self.replacingCharacters(in: foo[0], with: "|")
        let or1 = wow.split(separator: "|")
        return (String(or1[0]), String(or1[1]))
    }


    func indices(of searchTerm:String) -> [Int] {
        var indices = [Int]()
        var pos = self.startIndex
        while let range = range(of: searchTerm, range: pos ..< self.endIndex) {
            indices.append(distance(from: startIndex, to: range.lowerBound))
            pos = index(after: range.lowerBound)
        }
        return indices
    }

    func indices1(of searchTerm:String) -> [Range<String.Index>] {
        var indices = [Range<String.Index>]()
        var pos = self.startIndex
        while let range = range(of: searchTerm, range: pos ..< self.endIndex) {
            indices.append(range)
            pos = index(after: range.lowerBound)
        }
        return indices
    }

    
    func splitAt(_ here: Range<String.Index>) -> (String, String) {
        let wow = self.replacingCharacters(in: here, with: "|")
        let or1 = wow.split(separator: "|")
        return (String(or1[0]), String(or1[1]))
    }
    
}
