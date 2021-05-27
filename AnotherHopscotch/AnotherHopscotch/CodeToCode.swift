//
//  CodeToCode.swift
//  AnotherHopscotch
//
//  Created by Jonathan Pappas on 5/27/21.
//

import Foundation


var textual =
"""
var|a|=|101.int|_ind(0)
run|print($a)|_ind(0)
run|print($a.$foo)|_ind(0)
run|set($a.$foo,false)|_ind(0)
run|print($a.$foo)|_ind(0)
var|b|=|101.int|_ind(0)
run|print($b.$foo)|_ind(0)
"""
//run|print(int(1).inc)|_ind(0)
//run|print(100000000000000001.bigint.nextprime)|_ind(0)
//run|print(100101.rev)|_ind(0)

//struct|Foo|_ind(0)
//var|foo|=|0.int|_ind(1)
//run|print(Int())|_ind(0)
//run|print(Foo().foo)|_ind(0)



//var textual =
//"""
//run|print(123.int.rev)|_ind(0)
//run|print(123.int.palin)|_ind(0)
//run|print(101.bigint.isPrime)|_ind(0)
//run|print(101.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//"""

//run|print(1111111111111111111.bigint.isPrime)|_ind(0)
//run|print(11111111111111111111111.bigint.isPrime)|_ind(0)
//run|print(11001011011100111110110010101001111111001110101000010110001101100010011001111111111101001101100101101011011011001111001110011110011011011010110100110110010111111111110011001000110110001101000010101110011111110010101001101111100111011010011.bigint.isPrime)|_ind(0)
//run|print(6660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001.bigint.isPrime)|_ind(0)

// FIB
//var textual =
//"""
//var|one|=|0.bigint|_ind(0)
//var|two|=|1.bigint|_ind(0)
//while|true|_ind(0)
//var|sum|=|$one.add($two)|_ind(1)
//run|print($sum)|_ind(1)
//var|one|=|$two|_ind(1)
//var|two|=|$sum|_ind(1)
//"""

//var textual =
//"""
//func|doThis|_ind(0)
//return|$0|_ind(1)
//run|print(print())|_ind(0)
//run|print(doThis())|_ind(0)
//run|print(doThis(1))|_ind(0)
//run|print(doThis(2))|_ind(0)
//run|print(doThis(3, 1))|_ind(0)
//var|foo|=|0.int|_ind(0)
//repeat|10|times|_ind(0)
//run|print(0, 1)|_ind(1)
//for|i|in|range(1.int,7.int)|_ind(0)
//run|print(i.get)|_ind(1)
//for|i|in|hello|_ind(0)
//run|print(i.get)|_ind(1)
//while|true|_ind(0)
//run|set(foo,$foo.add(1.int))|_ind(1)
//run|print($foo)|_ind(1)
//if|get(foo).equals(10.int)|_ind(1)
//break|_ind(2)
//none|_ind(0)
//run|foo += 1|_ind(0)
//if|true|_ind(0)
//run|print(Hello World!)|_ind(1)
//else|true|_ind(0)
//run|print(Goodbye Cruel World?)|_ind(1)
//none|_ind(0)
//if|foo == 1|_ind(0)
//if|(5 + 5 + 5) == true|_ind(1)
//if|(5 + 5 + 5) == true|_ind(2)
//break|_ind(3)
//if|(5 + 5 + 5) == true|_ind(3)
//if|(5 + 10 + 5) == true|_ind(4)
//var|foobar|=|10|_ind(0)
//var|foobar|=|10|_ind(0)
//for|i|in|7|_ind(0)
//var|doThis|=|1101000|_ind(1)
//if|Bool.random()|_ind(1)
//continue|_ind(2)
//run|print(Hello World!)|_ind(1)
//
//struct|Foo|_ind(0)
//func|doThis|_ind(1)
//run|foo += 1|_ind(2)
//return|true|_ind(2)
//class|Foo|_ind(0)
//enum|Foo|_ind(0)
//case|foo|_ind(1)
//case|bar|_ind(1)
//"""
