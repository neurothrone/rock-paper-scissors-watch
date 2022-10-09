//
//  MoveImageView.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import SwiftUI

struct MoveImageView: View {
  let move: Move
  
  var body: some View {
    Image(move.rawValue)
      .resizable()
      .scaledToFit()
  }
}

struct MoveImageView_Previews: PreviewProvider {
  static var previews: some View {
    MoveImageView(move: .rock)
  }
}
