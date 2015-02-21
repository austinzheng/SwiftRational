//
//  rational.swift
//  SwiftRationalSampleApp
//
//  Created by Austin Zheng on 2/20/15.
//  Copyright (c) 2015 Austin Zheng. All rights reserved.
//

import Foundation

public struct Rational : Printable {
  public let numerator : Int
  public let denominator : Int

  public var description : String {
    return "\(numerator)/\(denominator)"
  }

  // Initialize a Rational from a numerator and a denominator.
  public init?(numerator: Int, denominator: Int) {
    if denominator == 0 {
      return nil
    }
    let common = gcd(abs(numerator), abs(denominator))
    if denominator < 0 {
      self.numerator = -numerator/common
      self.denominator = -denominator/common
    }
    else {
      self.numerator = numerator/common
      self.denominator = denominator/common
    }
  }

  // Initialize a Rational from an integer.
  public init(integer: Int) {
    self.numerator = integer
    self.denominator = 1
  }
}

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

extension Rational {
  
}
