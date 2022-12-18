//
//  ContentView.swift
//  Set
//
//  Created by Lukas Hering on 13.12.22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: GameOfSet
    
//gamedesign
    var body: some View {
        NavigationView {
            VStack {
                
                if !game.isEndOfGame {
                    AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                        CardView(card: card)
                            .padding(5)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                } else {
                    Text("Game Over").foregroundColor(.green).font(.largeTitle)
                }
                
                HStack {
                    Spacer()
                    Button { game.newGame() } label: { Text("New Game") }
                    Spacer()
                    if !game.isEndOfGame {
                        if game.numberOfPlayedCards < game.totalNumberOfCards {
                            Button { game.dealThreeCards() } label: { Text("Deal 3 Cards") }
                        } else {
                            Text("Deal 3 Cards").foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                .padding(.bottom)
            }
            .padding()
            .foregroundColor(.blue)
            .navigationBarTitle("Set!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameOfSet()
        SetGameView(game: game)
    }
}
