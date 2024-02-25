//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by jason on 2/2/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            Text(viewModel.getTheme().name)
                .font(.title)
            cards
                .animation(.default, value: viewModel.cards)
            HStack {
                newGameButton()
                Spacer()
                Text("Score: \(viewModel.getScore())").font(.title2)
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .foregroundColor(viewModel.getTheme().color)
        }
    
    func newGameButton() -> some View {
        Button (action: {
            viewModel.newGame()
        }, label: {
            Text("New Game").font(.title2)
        })
    }
}
    
    struct CardView: View {
        let card: MemoryGame<String>.Card
        
        init(_ card: MemoryGame<String>.Card) {
            self.card = card
        }
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                base.fill().opacity(card.isFaceUp ? 0 : 1)
            }
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
