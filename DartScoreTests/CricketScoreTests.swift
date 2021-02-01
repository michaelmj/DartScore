//
//  CricketScoreTests.swift
//  DartScoreTests
//
//  Created by Michael Malinak on 1/30/21.
//

import XCTest

class CricketScoreTests: XCTestCase {
   
   override func setUpWithError() throws {
   }
   
   override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   }

   func testNewGameStartsAtZero() throws {
      let cricket = CricketScores()

      XCTAssertEqual(cricket.scoreFor(.playerOne), 0)
   }

   func testClosingDoesNotScore() throws {
      let cricket = CricketScores()
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .triple))
      cricket.addThrow(DartThrow(player:.playerTwo, number:.fifteen, multipler: .triple))

      XCTAssertEqual(cricket.scoreFor(.playerOne), 0)
      XCTAssertEqual(cricket.scoreFor(.playerTwo), 0)
   }

   func testShotAfterCloseScoresPoints() throws {
      let cricket = CricketScores()
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .triple))
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .single))
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .single))

      XCTAssertEqual(cricket.scoreFor(.playerOne), 30)
      XCTAssertEqual(cricket.scoreFor(.playerTwo), 0)
   }

   func testOtherPlayerCantScoreOnClosed() throws {
      let cricket = CricketScores()
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .triple))

      cricket.addThrow(DartThrow(player:.playerTwo, number:.fifteen, multipler: .triple))
      cricket.addThrow(DartThrow(player:.playerTwo, number:.fifteen, multipler: .single))

      XCTAssertEqual(cricket.scoreFor(.playerOne), 0)
      XCTAssertEqual(cricket.scoreFor(.playerTwo), 0)
   }

   func testOtherPlayerCantScoreWhenHavingPoints() throws {
      let cricket = CricketScores()
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .triple))
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .single))
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .single))

      cricket.addThrow(DartThrow(player:.playerTwo, number:.fifteen, multipler: .triple))
      cricket.addThrow(DartThrow(player:.playerTwo, number:.fifteen, multipler: .single))

      XCTAssertEqual(cricket.scoreFor(.playerOne), 30)
      XCTAssertEqual(cricket.scoreFor(.playerTwo), 0)
   }

   func testBothClosedNoMoreScore() throws {
      let cricket = CricketScores()
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .triple))
      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .single))

      cricket.addThrow(DartThrow(player:.playerTwo, number:.fifteen, multipler: .triple))

      cricket.addThrow(DartThrow(player:.playerOne, number:.fifteen, multipler: .single))

      XCTAssertEqual(cricket.scoreFor(.playerOne), 15)
      XCTAssertEqual(cricket.scoreFor(.playerTwo), 0)
   }
   
}
