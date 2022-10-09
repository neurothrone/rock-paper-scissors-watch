//
//  MoveButtonsView.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import SwiftUI

struct MoveButtonsView: View {
  private struct MoveButtonView: View {
    let move: Move
    let onMoveSelected: (Move) -> Void
    
    var body: some View {
      Button {
        onMoveSelected(move)
      } label: {
        MoveImageView(move: move)
      }
      .buttonStyle(.plain)
    }
  }
  
  let moves: [Move]
  let onMoveSelected: (Move) -> Void
  
  var body: some View {
    HStack {
      ForEach(Array(zip(moves.indices, moves)), id: \.1) { index, move in
        Group {
          if index == .one {
            MoveButtonView(move: move, onMoveSelected: onMoveSelected)
              .horizontalSpacing()
          } else {
            MoveButtonView(move: move, onMoveSelected: onMoveSelected)
          }
        }
        .buttonStyle(.plain)
      }
    }
  }
}

struct MoveButtonsView_Previews: PreviewProvider {
  static var previews: some View {
    MoveButtonsView(moves: Move.allCases, onMoveSelected: { _ in })
  }
}
