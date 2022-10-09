//
//  ContentView.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-08.
//

import SwiftUI

enum Move: String {
  case rock, paper, scissors
}

extension Move: CaseIterable, Identifiable {
  var id: Self { self }
  
  /// Returns a random Move of all possible cases
  static func random() -> Move {
    Self.allCases.randomElement() ?? .rock
  }
}

struct ContentView: View {
  @State private var shouldWin = true
  @State private var level: Int = .one
  @State private var isGameOver = false
  
  @State private var title = "Win!"
  @State private var questionMove: Move = .random()
  
  @State private var currentTime: Date = .now
  @State private var startTime: Date = .now
  
  private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
  
  private let solutions: [Move: (win: Move, lose: Move)] = [
    .rock: (win: .paper, lose: .scissors),
    .paper: (win: .scissors, lose: .rock),
    .scissors: (win: .rock, lose: .paper)
  ]
  
  var time: String {
    // timeIntervalSince() returns time passed with great accuracy, e.g. 3.1971465
    let difference = currentTime.timeIntervalSince(startTime)
    return String(Int(difference))
  }
  
  var body: some View {
    content
      .navigationTitle(title)
      .onAppear(perform: newLevel)
      .onReceive(timer) { newTime in
        guard !isGameOver else { return }
        currentTime = newTime
      }
  }
  
  @ViewBuilder
  var content: some View {
    if !isGameOver {
      game
    } else {
      end
    }
  }
  
  var game: some View {
    VStack {
      MoveImage(move: questionMove)
      
      Divider()
        .padding(.vertical)
      
      HStack {
        ForEach(Move.allCases) { move in
          if move == .paper {
            Button {
              select(move: move)
            } label: {
              MoveImage(move: move)
            }
            .buttonStyle(.plain)
            .horizontalSpacing()
          } else {
            Button {
              select(move: move)
            } label: {
              MoveImage(move: move)
            }
            .buttonStyle(.plain)
          }
        }
      }
      .padding(.horizontal)
      
      HStack {
        Text("Level: \(level)/20")
        Spacer()
        Text("Time: \(time)")
      }
      .padding([.top, .horizontal])
    }
  }
  
  var end: some View {
    VStack {
      Text("You win!")
        .font(.largeTitle)
      
      Text("Your time: \(time) seconds")
      
      Button("Play again") {
        startTime = .now
        isGameOver = false
        level = .one
        newLevel()
      }
      .buttonStyle(.borderedProminent)
      .tint(.purple)
    }
  }
}

struct MoveImage: View {
  let move: Move
  
  var body: some View {
    Image(move.rawValue)
      .resizable()
      .scaledToFit()
  }
}

extension ContentView {
  private func select(move: Move) {
    guard let answer = solutions[questionMove] else {
      fatalError("❌ -> Unknown question: \(questionMove)")
    }
    
    let wasCorrect = move == (shouldWin ? answer.win : answer.lose)
    level += wasCorrect ? 1 : -1
    level.clamp(min: 1, max: 20)
    
    newLevel()
  }
  
  private func newLevel() {
    if level >= 20 {
      isGameOver = true
      return
    }
    
    shouldWin = Bool.random()
    title = shouldWin ? "Win!" : "Lose!"
    questionMove = Move.random()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
