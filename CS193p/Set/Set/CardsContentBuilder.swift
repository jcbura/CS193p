//
//  CardsContentBuilder.swift
//  Set
//
//  Created by jason on 2/28/24.
//

import Foundation

struct CardsContentBuilder {
    var cardsContent: [CardContent] = []
    
    init() {
        // Initializes an array of all CardContent item possibilities.
        var card: CardContent
        for color in CardContent.SetColor.allCases {
            for number in CardContent.SetNumber.allCases {
                for shading in CardContent.SetShading.allCases {
                    for shape in CardContent.SetShape.allCases {
                        card = CardContent(color, number, shading, shape)
                        cardsContent.append(card)
                    }
                }
            }
        }
    }
    
    struct CardContent {
        var color: SetColor
        var number: SetNumber
        var shading: SetShading
        var shape: SetShape
        
        init(_ color: SetColor, _ number: SetNumber, _ shading: SetShading, _ shape: SetShape) {
            // Initializes a CardContent item with it's color, number, shading, and shape.
            self.color = color
            self.number = number
            self.shading = shading
            self.shape = shape
        }
        
        enum SetColor: CaseIterable {
            case green, blue, pink
        }
        
        enum SetNumber: CaseIterable {
            case one, two, three
        }
        
        enum SetShading: CaseIterable {
            case transparent, opaque, solid
        }
        
        enum SetShape: CaseIterable {
            case diamond, rectangle, ellipse
        }
    }
}
