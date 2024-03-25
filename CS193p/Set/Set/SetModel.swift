//
//  SetModel.swift
//  Set
//
//  Created by jason on 3/24/24.
//

import Foundation

struct SetModel {
    private(set) var cards: [Card]
    private(set) var displayedCards: [Card]
    private(set) var deck: [Card]

    init() {
        cards = []
        displayedCards = []
        deck = []
        
        let colors = ["orange", "blue", "purple"]
        let numbers = [1, 2, 3]
        let opacities = [0.0, 0.25, 1.0]
        let shapes = ["rectangle", "circle", "triangle"]

        for color in colors {
            for number in numbers {
                for opacity in opacities {
                    for shape in shapes {
                        let card = Card(color: color, number: number, opacity: opacity, shape: shape)
                        cards.append(card)
                    }
                }
            }
        }
        cards.shuffle()
        displayedCards = Array(cards.prefix(12))
        deck = Array(cards.dropFirst(12))
    }
    
    mutating func selectCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            displayedCards[index].selected.toggle()
        }
    }
    
    func threeCardsSelected() -> Bool {
        let selectedCardsCount = displayedCards.filter { $0.selected }.count
        return selectedCardsCount == 3
    }
    
    func validSet() -> Bool {
        let selectedCards = displayedCards.filter { $0.selected }
        
        let colors = Set(selectedCards.map { $0.color })
        let numbers = Set(selectedCards.map { $0.number })
        let opacities = Set(selectedCards.map { $0.opacity })
        let shapes = Set(selectedCards.map { $0.shape })
        
        let isColorsValid = colors.count == 1 || colors.count == 3
        let isNumbersValid = numbers.count == 1 || numbers.count == 3
        let isOpacitiesValid = opacities.count == 1 || opacities.count == 3
        let isShapesValid = shapes.count == 1 || shapes.count == 3
        
        return isColorsValid && isNumbersValid && isOpacitiesValid && isShapesValid
    }

    struct Card: Hashable, Identifiable {
        var id = UUID()
        let color: String
        let number: Int
        let opacity: Double
        var selected = false
        let shape: String

        var shapeFill: String {
            "\(shape).fill"
        }
    }
}
