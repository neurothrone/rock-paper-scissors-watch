//
//  Int+Extensions.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import Foundation

extension Int {
  /// The one value.
  @inlinable public static var one: Int { 1 }
  
  mutating func clamp(min: Int, max: Int) {
    switch self {
    case self where self > max:
      self = max
    case self where self < min:
      self = min
    default:
      return
    }
  }
}
