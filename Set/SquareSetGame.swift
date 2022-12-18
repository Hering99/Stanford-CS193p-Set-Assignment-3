//
//  SquareSetGame.swift
//  Set
//
//  Created by Lukas Hering on 14.12.22.
//

import SwiftUI

//creating the game with a total maximum of 81 cards
class GameOfSet: ObservableObject {
    typealias Card = SetGame<ContentShape, ContentColor, ContentPattern, NumberOfContentShapes>.Card
    
    static var cardContents: [Card.CardContent] = {
        var contents = [Card.CardContent]()

//      9 DECK OF CARDS
//        for shape in ContentShape.allCases {
//            for color in ContentColor.allCases {
//                    contents.append(Card.CardContent(shape: shape, color: color, pattern: .stroked, numberOfShapes: 1))
//            }
//        }
        
//      12 DECK OF CARDS
//        for shape in ContentShape.allCases {
//            for color in ContentColor.allCases {
//                for number in NumberOfContentShapes.allCases {
//                    contents.append(Card.CardContent(shape: shape, color: color, pattern: .stroked, numberOfShapes: number.rawValue))
//                }
//            }
//        }
        

//      81 CARDS
        
        for shape in ContentShape.allCases {
            for color in ContentColor.allCases {
                for pattern in ContentPattern.allCases {
                    for numberOfShapes in NumberOfContentShapes.allCases {
                        contents.append(Card.CardContent( shape: shape, color: color, pattern: pattern, numberOfShapes: numberOfShapes.rawValue))
                    }
                }
            }
        }
        
        return contents.shuffled()
    }()
    
    static private func createSetGame() -> SetGame<ContentShape, ContentColor, ContentPattern, NumberOfContentShapes> {
        SetGame(initialNumberOfPlayingCards: 12, totalNumberOfCards: cardContents.count) { cardContents[$0] }
    }
    
    
    @Published private var model = createSetGame()
    
    var cards: [Card] {
        model.playingCards
    }
    
    var numberOfPlayedCards: Int {
        model.numberOfPlayedCards
    }
    
    var totalNumberOfCards: Int {
        model.totalNumberOfCards
    }
    
    var isEndOfGame: Bool {
        model.isEndOfGame
    }

    
    // MARK: -Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeCards() {
        model.dealThreeCards()
    }
    
    func newGame() {
        GameOfSet.cardContents.shuffle()
        model = GameOfSet.createSetGame()
        
    }
    
    
    enum ContentShape: CaseIterable {
        case roundedRectangle
        case diamond
        case squiggle
    }
    
    enum ContentColor: CaseIterable {
        case red
        case green
        case purple
        
        func getColor() -> Color {
            switch self {
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .purple:
                return Color.purple
            }
        }
    }
    
    enum ContentPattern: CaseIterable {
        case filled
        case stroked
        case shaded
    }
    
    enum NumberOfContentShapes: Int, CaseIterable {
        case one = 1
        case two
        case three
    }
    
}
