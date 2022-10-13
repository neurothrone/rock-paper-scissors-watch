//
//  LevelAndScoreTextView.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import SwiftUI

struct LevelAndScoreTextView: View {
  let level: Int
  let maxLevel: Int
  let time: String
  let levelColor: Color
  
  var body: some View {
    HStack {
      Text("Level:")
        .foregroundColor(levelColor)
      Text("\(level)/\(maxLevel)")
      Spacer()
      Text("Time: \(time)")
    }
  }
}

struct LevelAndScoreTextView_Previews: PreviewProvider {
  static var previews: some View {
    LevelAndScoreTextView(level: 7, maxLevel: 20, time: "59", levelColor: .primary)
  }
}
