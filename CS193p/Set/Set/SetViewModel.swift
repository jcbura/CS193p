//
//  SetViewModel.swift
//  Set
//
//  Created by jason on 2/28/24.
//

import SwiftUI

class SetViewModel: ObservableObject {
    var cardsContentBuilder: CardsContentBuilder
    var translatedCardsContent: TranslatedCardsContent
    
    init() {
        cardsContentBuilder = CardsContentBuilder()
        translatedCardsContent = TranslatedCardsContent(cardsContentBuilder)
    }
    
    
    
    struct TranslatedCardsContent {
        var translatedCardsContent: [TranslatedCardContent] = []
        
        init(_ cardsContentBuilder: CardsContentBuilder) {
            var translatedCardContent: TranslatedCardContent
            for cardContent in cardsContentBuilder.cardsContent {
                translatedCardContent = TranslatedCardContent(cardContent.color, cardContent.number, cardContent.shading, cardContent.shape)
                translatedCardsContent.append(translatedCardContent)
            }
        }
        
        struct TranslatedCardContent {
            var color: Color = .clear // will be overwritten
            var number: Int = 0 // will be overwritten
            var shading: Double = 0 // will be overwritten
            var shape: any Shape = Rectangle() // will be overwritten
            
            init(
                _ color: CardsContentBuilder.CardContent.SetColor,
                _ number: CardsContentBuilder.CardContent.SetNumber,
                _ shading: CardsContentBuilder.CardContent.SetShading,
                _ shape: CardsContentBuilder.CardContent.SetShape
            ) {
                self.color = translateColor(color)
                self.number = translateNumber(number)
                self.shading = translateShading(shading)
                self.shape = translateShape(shape)
            }
            
            func translateColor(_ color: CardsContentBuilder.CardContent.SetColor) -> Color {
                switch color {
                case CardsContentBuilder.CardContent.SetColor.green:
                    return Color.green
                case CardsContentBuilder.CardContent.SetColor.blue:
                    return Color.blue
                case CardsContentBuilder.CardContent.SetColor.pink:
                    return Color.pink
                }
            }
            
            func translateNumber(_ number: CardsContentBuilder.CardContent.SetNumber) -> Int {
                switch number {
                case CardsContentBuilder.CardContent.SetNumber.one:
                    return 1
                case CardsContentBuilder.CardContent.SetNumber.two:
                    return 2
                case CardsContentBuilder.CardContent.SetNumber.three:
                    return 3
                }
            }
            
            func translateShading(_ shading: CardsContentBuilder.CardContent.SetShading) -> Double {
                switch shading {
                case CardsContentBuilder.CardContent.SetShading.transparent:
                    return 0
                case CardsContentBuilder.CardContent.SetShading.opaque:
                    return 0.5
                case CardsContentBuilder.CardContent.SetShading.solid:
                    return 1
                }
            }
            
            func translateShape(_ shape: CardsContentBuilder.CardContent.SetShape) -> any Shape {
                switch shape {
                case CardsContentBuilder.CardContent.SetShape.diamond:
                    return Diamond()
                case CardsContentBuilder.CardContent.SetShape.rectangle:
                    return Rectangle()
                case CardsContentBuilder.CardContent.SetShape.ellipse:
                    return Ellipse()
                }
            }
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        path.closeSubpath()

        return path
    }
}
