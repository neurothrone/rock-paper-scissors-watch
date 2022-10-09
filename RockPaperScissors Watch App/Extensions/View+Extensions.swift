//
//  View+Extensions.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import SwiftUI

extension View {
  func horizontalSpacing() -> some View {
    Group {
      Spacer()
      self
      Spacer()
    }
  }
}

