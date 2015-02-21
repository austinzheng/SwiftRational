//
//  main.swift
//  SwiftRationalSampleApp
//
//  Created by Austin Zheng on 2/20/15.
//  Copyright (c) 2015 Austin Zheng. All rights reserved.
//

import Foundation
import SwiftRational

println("Welcome to SwiftRational's demo app!\n")

// Rationals can be constructed from integers, doubles, or as fractions

let r1 : Rational = 15
let r2 : Rational = Rational(152, 71)
let r3 : Rational = 1.159282

println("Rationals can be constructed from integers, doubles, or as fractions:")
println("r1 is \(r1), r2 is \(r2), r3 is \(r3)")


// Rationals can be compared

let r4 = Rational(1, 2)
let r5 = Rational(1, 2)
let r6 = Rational(2, 3)
let r7 = Rational(7, 9)

println("\nRationals can be compared:")
println("\(r4) == \(r5)? \(r4 == r5)")
println("\(r5) < \(r6) < \(r7)? \(r5 < r6 && r6 < r7)")


// Do math with rationals

println("\nDo math with rationals:")
let r8 = Rational(57, 12)
let r9 = Rational(7, -19)
println("\(r8) + \(r9) = \(r8 + r9)")
println("\(r8) - \(r9) = \(r8 - r9)")
println("\(r8) * \(r9) = \(r8 * r9)")
println("\(r8) / \(r9) = \(r8 / r9)")


// Do more math with rationals

println("\nDo more math with rationals:")
let r10 = Rational(5, 992)
println("-(\(r10)) = \(-r10)")
println("(\(r10))^-1 = \(r10.inverse!)")


// Turn rationals back into other numeric types

println("\nTurn rationals back into other numeric types:")
let r11 = Rational(6, 129)
println("\(r11) has a numerator of \(r11.numerator), denominator of \(r11.denominator)")
println("\(r11)'s floating-point value is \(r11.doubleValue)")
