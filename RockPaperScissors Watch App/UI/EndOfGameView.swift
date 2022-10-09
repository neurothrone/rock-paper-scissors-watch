//
//  EndOfGameView.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import SwiftUI

struct EndOfGameView: View {
  let time: String
  let onPlayAgainClicked: () -> Void
  
  var body: some View {
    VStack {
      Text("You win!")
        .font(.largeTitle)
      
      Text("Your time: \(time) seconds")
      
      Button("Play again", action: onPlayAgainClicked)
        .buttonStyle(.borderedProminent)
        .tint(.purple)
    }
  }
}

struct EndOfGameView_Previews: PreviewProvider {
  static var previews: some View {
    EndOfGameView(time: "213", onPlayAgainClicked: {})
  }
}
