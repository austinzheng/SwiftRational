//
//  rational.swift
//  SwiftRationalSampleApp
//
//  Created by Austin Zheng on 2/20/15.
//  Copyright (c) 2015 Austin Zheng. All rights reserved.
//

import Foundation

/// A rational number, described by an integer numerator and an integer denominator.
public struct Rational : AbsoluteValuable, Comparable, FloatLiteralConvertible, Hashable, Printable {
  // INVARIANT: A rational is always stored as an irreducable fraction. Rationals built from other numeric types are
  //  fully reduced at initialization. If this invariant is violated, rational operations are not guaranteed to return
  //  the correct results.

  // 10^maximumPower is the maximum possible denominator when constructing a rational from a double.
  // We calculate this by taking the floor of the base-10 log of Int.max. (This value is cached.)
  private static var maximumPower : Int = Int(log10(Double(Int.max)))

  /// The numerator of the rational number.
  public let numerator : Int

  /// The denominator of the rational number.
  public let denominator : Int

  public var hashValue : Int {
    return numerator ^ denominator
  }

  public var description : String {
    return "\(numerator)/\(denominator)"
  }

  /// The rational number's value, as a double-precision floating-point value.
  public var doubleValue : Double {
    return Double(numerator) / Double(denominator)
  }

  /// The rational number's multiplicative inverse, or nil if the inverse would be x/0.
  public var inverse : Rational? {
    return numerator == 0 ? nil : Rational(denominator, numerator)
  }

  // Initialize a Rational from a numerator and a denominator.
  public init(_ n: Int, _ d: Int) {
    if d == 0 {
      fatalError("Rational cannot be initialized with a denominator of 0")
    }
    let common = gcd(abs(n), abs(d))
    if d < 0 {
      numerator = -n/common
      denominator = -d/common
    }
    else {
      numerator = n/common
      denominator = d/common
    }
  }

  // Initialize a Rational from an integer or an integer literal.
  public init(integerLiteral value: Int) {
    self.init(value, 1)
  }

  // Initialize a Rational from a double.
  public init(floatLiteral value: Double) {
    if (value.isInfinite || value.isNaN || value.isSubnormal) {
      fatalError("Rational can only be constructed using a normal double.")
    }
    var n = abs(value)
    var d = 1 as Double
    for i in 0..<Rational.maximumPower {
      if n % 1 == 0 {
        break
      }
      n *= 10
      d *= 10
    }
    self.init((value.isSignMinus ? -1 : 1) * lround(n), Int(d))
  }
}


// MARK: Math

public func ==(lhs: Rational, rhs: Rational) -> Bool {
  return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
}

public func <(lhs: Rational, rhs: Rational) -> Bool {
  return lhs.numerator * rhs.denominator < lhs.denominator * rhs.numerator
}

public prefix func -(arg: Rational) -> Rational {
  return Rational(-arg.numerator, arg.denominator)
}

public func +(lhs: Rational, rhs: Rational) -> Rational {
  if (lhs.denominator == rhs.denominator) {
    return Rational(lhs.numerator + rhs.numerator, lhs.denominator)
  }
  let n = lhs.numerator * rhs.denominator + lhs.denominator * rhs.numerator
  let d = lhs.denominator * rhs.denominator
  return Rational(n, d)
}

public func -(lhs: Rational, rhs: Rational) -> Rational {
  if (lhs.denominator == rhs.denominator) {
    return Rational(lhs.numerator - rhs.numerator, lhs.denominator)
  }
  let n = lhs.numerator * rhs.denominator - lhs.denominator * rhs.numerator
  let d = lhs.denominator * rhs.denominator
  return Rational(n, d)
}

public func *(lhs: Rational, rhs: Rational) -> Rational {
  let n = lhs.numerator * rhs.numerator
  let d = lhs.denominator * rhs.denominator
  return Rational(n, d)
}

public func /(lhs: Rational, rhs: Rational) -> Rational {
  return (lhs * rhs).inverse!
}

public func += ( inout lhs:Rational, rhs:Rational ) {
	lhs = lhs + rhs
}

public func -= ( inout lhs:Rational, rhs:Rational ) {
	lhs = lhs - rhs
}

public func *= ( inout lhs:Rational, rhs:Rational ) {
	lhs = lhs * rhs
}

public func /= ( inout lhs:Rational, rhs:Rational ) {
	lhs = lhs / rhs
}

// MARK: Supplementary math

public extension Rational {

  static func abs(x: Rational) -> Rational {
    let n = x.numerator
    return Rational((n < 0 ? -n : n), x.denominator)
  }

  /// Add `lhs` and `rhs`, returning a result and a `Bool` that is true iff the operation caused an arithmetic overflow.
  static func addWithOverflow(lhs: Rational, _ rhs: Rational) -> (Rational, overflow: Bool) {
    if (lhs.denominator == rhs.denominator) {
      let (n, didOverflow) = Int.addWithOverflow(lhs.numerator, rhs.numerator)
      return (Rational(n, lhs.denominator), didOverflow)
    }
    let (ad, of1) = Int.multiplyWithOverflow(lhs.numerator, rhs.denominator)
    let (bc, of2) = Int.multiplyWithOverflow(lhs.denominator, rhs.numerator)
    let (adPbc, of3) = Int.addWithOverflow(ad, bc)
    let (bd, of4) = Int.multiplyWithOverflow(lhs.denominator, rhs.denominator)
    return (Rational(adPbc, bd), of1 || of2 || of3 || of4)
  }

  /// Subtract `lhs` and `rhs`, returning a result and a `Bool` that is true iff the operation caused an arithmetic
  /// overflow.
  static func subtractWithOverflow(lhs: Rational, _ rhs: Rational) -> (Rational, overflow: Bool) {
    if (lhs.denominator == rhs.denominator) {
      let (n, didOverflow) = Int.subtractWithOverflow(lhs.numerator, rhs.numerator)
      return (Rational(n, lhs.denominator), didOverflow)
    }
    let (ad, f1) = Int.multiplyWithOverflow(lhs.numerator, rhs.denominator)
    let (bc, f2) = Int.multiplyWithOverflow(lhs.denominator, rhs.numerator)
    let (adMbc, f3) = Int.subtractWithOverflow(ad, bc)
    let (bd, f4) = Int.multiplyWithOverflow(lhs.denominator, rhs.denominator)
    return (Rational(adMbc, bd), f1 || f2 || f3 || f4)
  }

  /// Multiply `lhs` and `rhs`, returning a result and a `Bool` that is true iff the operation caused an arithmetic
  /// overflow.
  static func multiplyWithOverflow(lhs: Rational, _ rhs: Rational) -> (Rational, overflow: Bool) {
    let (ac, f1) = Int.multiplyWithOverflow(lhs.numerator, rhs.numerator)
    let (bd, f2) = Int.multiplyWithOverflow(lhs.denominator, rhs.denominator)
    return (Rational(ac, bd), f1 || f2)
  }

  /// Divide `lhs` and `rhs`, returning a result and a `Bool` that is true iff the operation caused an arithmetic
  /// overflow.
  static func divideWithOverflow(lhs: Rational, _ rhs: Rational) -> (Rational, overflow: Bool) {
    let (ac, f1) = Int.multiplyWithOverflow(lhs.numerator, rhs.numerator)
    let (bd, f2) = Int.multiplyWithOverflow(lhs.denominator, rhs.denominator)
    return (Rational(ac, bd).inverse!, f1 || f2)
  }
}


// MARK: Utilities

/// Return the greatest common divisor for the two integer arguments. This function uses the iterative Euclidean
/// algorithm for calculating GCD.
func gcd(u: Int, v: Int) -> Int {
  var a = u
  var b = v
  while b != 0 {
    let t = b
    b = a % b
    a = t
  }
  return a
}
