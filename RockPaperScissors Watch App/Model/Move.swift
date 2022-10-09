//
//  Move.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import Foundation

enum Move: String {
  case rock, paper, scissors
}

extension Move: CaseIterable, Identifiable {
  var id: Self { self }
  
  /// Returns a random Move of all possible cases
  static func random() -> Move {
    Self.allCases.randomElement() ?? .rock
  }
  
  static func uniqueRandom(not thisMove: Move) -> Move {
    while true {
      let newMove = Self.random()
      
      if newMove != thisMove {
        return newMove
      }
    }
  }
}
