//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by jason on 2/19/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    var gameTheme: Theme
    @Published private var model: MemoryGame<String>
    
    init() {
        gameTheme = Theme()
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }

    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emoji.indices.contains(pairIndex) {
                return theme.emoji[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        gameTheme = Theme()
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme) 
    }
    
    func getTheme() -> (name: String, color: Color) {
        let name = gameTheme.name
        let colorName = gameTheme.color
        var color: Color
        switch colorName {
        case "red":
            color = Color.red
        case "orange":
            color = Color.orange
        case "yellow":
            color = Color.yellow
        case "green":
            color = Color.green
        case "blue":
            color = Color.blue
        case "purple":
            color = Color.purple
        default:
            // Should never reach default case.
            color = Color.white
        }
        return (name, color)
    }
    
    func getScore() -> Int {
        model.getScore()
    }
}
