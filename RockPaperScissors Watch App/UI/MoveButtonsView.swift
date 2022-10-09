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
  
  let onMoveSelected: (Move) -> Void
  
  var body: some View {
    HStack {
      ForEach(Move.allCases) { move in
        Group {
          if move == .paper {
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
    MoveButtonsView(onMoveSelected: { _ in })
  }
}
