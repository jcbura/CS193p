//
//  SetViewModel.swift
//  Set
//
//  Created by jason on 3/24/24.
//

import SwiftUI

class SetViewModel: ObservableObject {
    @Published private var model = SetModel()
    
    var displayedCards: [SetModel.Card] {
        model.displayedCards
    }
    
    func selectCard(_ card: SetModel.Card) {
        model.selectCard(card)
    }

    func colorConverter(_ color: String) -> Color {
        switch color {
        case "orange":
            return .orange
        case "blue":
            return .blue
        default:
            return .purple
        }
    }

    func shapeConverter(_ shape: String) -> Image {
        Image(systemName: shape)
    }
}
