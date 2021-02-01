//
//  CricketScore.swift
//  DartScore
//
//  Created by Michael Malinak on 1/30/21.
//

import Foundation

enum CricketNumber : Int, CaseIterable {
   case fifteen = 15
   case sixteen = 16
   case seventeen = 17
   case eightteen = 18
   case nineteen = 19
   case twenty = 20
   case bullseye = 25
}

enum Multiplier : Int{
   case single = 1
   case double = 2
   case triple = 3
}

enum Player: CaseIterable {
   case playerOne
   case playerTwo
}

struct DartThrow {
   let player: Player
   let number: CricketNumber
   let multipler: Multiplier
}

class CricketScores {
   private var throwList = [DartThrow]()
   private var score = [Player: Int]()
   private var countedShouts = [Player:[CricketNumber:Int]]()

   init() {
      score[.playerOne] = 0
      score[.playerTwo] = 0
      countedShouts[.playerOne] = [CricketNumber:Int]()
      countedShouts[.playerTwo] = [CricketNumber:Int]()
   }

   func calcScore() -> [Player: Int] {
      var score = [Player: Int]()
      score[.playerOne] = 0
      score[.playerTwo] = 0

      for player in countedShouts.keys {
         for number in countedShouts[player]!.keys {
            if let hits = countedShouts[player]?[number] {
               if hits > 3 {
                  score[player, default:0] += (hits - 3) * number.rawValue
               }
            }
         }
      }
      return score
   }

   func addThrow(_ dartThrow:DartThrow) {
      let otherPlayers = Player.allCases.filter { $0 != dartThrow.player }

      for otherPlayer in otherPlayers {
         if ( countedShouts[otherPlayer]![dartThrow.number, default: 0] >= 3 ) {
            return
         }
      }

      throwList.append(dartThrow)
      countedShouts[dartThrow.player]![dartThrow.number, default: 0] += dartThrow.multipler.rawValue

      self.score = calcScore()
   }

   func scoreFor(_ player: Player) -> Int {
      return score[ player, default: 0 ]
   }
}
