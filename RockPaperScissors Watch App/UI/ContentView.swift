//
//  ContentView.swift
//  RockPaperScissors Watch App
//
//  Created by Zaid Neurothrone on 2022-10-08.
//

import SwiftUI

struct ContentView: View {
  @State private var shouldWin = true
  @State private var level: Int = .one
  @State private var isGameOver = false
  
  @State private var title = "Win!"
  @State private var questionMove: Move = .random()
  
  @State private var currentTime: Date = .now
  @State private var startTime: Date = .now
  
  @State private var moves: [Move] = Move.allCases
  
  @State private var levelColor: Color = .primary
  
  private let maxLevels = 20
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
    NavigationStack {
      content
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: newLevel)
        .onReceive(timer) { newTime in
          guard !isGameOver else { return }
          currentTime = newTime
        }
    }
  }
  
  @ViewBuilder
  var content: some View {
    if isGameOver {
      EndOfGameView(time: time, onPlayAgainClicked: restartGame)
    } else {
      game
    }
  }
  
  var game: some View {
    VStack {
      MoveImageView(move: questionMove)
      
      Divider()
        .padding(.vertical)
      
      MoveButtonsView(moves: moves, onMoveSelected: selectMove)
        .padding(.horizontal)
        .disabled(levelColor != .primary)
      
      LevelAndScoreTextView(level: level, maxLevel: maxLevels, time: time, levelColor: levelColor)
        .padding([.top, .horizontal])
    }
  }
}

extension ContentView {
  private func selectMove(_ move: Move) {
    guard let answer = solutions[questionMove] else {
      fatalError("❌ -> Unknown question: \(questionMove)")
    }
    
    let wasCorrect = move == (shouldWin ? answer.win : answer.lose)
    level += wasCorrect ? .one : -.one
    level.clamp(min: .one, max: maxLevels)
    
    withAnimation(.easeInOut) {
      levelColor = wasCorrect ? .green : .red      
    }
    
    Task {
      try await Task.sleep(until: .now + .milliseconds(500), clock: .continuous)
      levelColor = .primary
    }
    
    newLevel()
  }
  
  private func newLevel() {
    if level >= maxLevels {
      isGameOver = true
      return
    }
    
    shouldWin = Bool.random()
    title = shouldWin ? "Win!" : "Lose!"
    questionMove = Move.uniqueRandom(not: questionMove)
    moves.shuffle()
  }
  
  private func restartGame() {
    startTime = .now
    isGameOver = false
    level = .one
    newLevel()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
