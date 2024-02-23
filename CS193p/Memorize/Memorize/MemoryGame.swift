//
//  MemoryGame.swift
//  Memorize
//
//  Created by jason on 2/19/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { return cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            cards[chosenIndex].seenCount+=1
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score+=2
                    } else if cards[chosenIndex].seenCount > 1 && cards[potentialMatchIndex].seenCount > 1 {
                        score-=2
                    } else if cards[chosenIndex].seenCount > 1 && cards[potentialMatchIndex].seenCount <= 1 {
                        score-=1
                    } else if cards[chosenIndex].seenCount <= 1 && cards[potentialMatchIndex].seenCount > 1 {
                        score-=1
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }

    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    func getScore() -> Int {
        return score
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var seenCount = 0
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}