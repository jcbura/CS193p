//
//  SetView.swift
//  Set
//
//  Created by jason on 3/24/24.
//

import SwiftUI

struct CardView: View {
    let card: SetModel.Card
    let viewModel: SetViewModel
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                viewModel.selectCard(card)
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                        .shadow(color: card.selected ? viewModel.colorConverter(card.color) : .gray, radius: 3)
                    
                    VStack {
                        ForEach(0..<card.number, id: \.self) { _ in
                            viewModel.shapeConverter(card.shape)
                                .foregroundStyle(viewModel.colorConverter(card.color))
                                .overlay (
                                    viewModel.shapeConverter(card.shapeFill)
                                        .foregroundStyle(viewModel.colorConverter(card.color))
                                        .opacity(card.opacity)
                                )
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                                .padding(.vertical, geometry.size.height * 0.01)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}


struct SetView: View {
    @ObservedObject var viewModel = SetViewModel()
    
    private let cardAspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            Text("Set")
                .font(.title.bold())
                
            AspectVGrid(viewModel.displayedCards, aspectRatio: cardAspectRatio) { card in
                CardView(card: card, viewModel: viewModel)
                    .padding(5)
            }
            .padding(.horizontal)
                
            HStack(spacing: 30) {
                Button("3 More Cards") {
                        
                }
                .buttonStyle(.bordered)
                    
                Button("New Game") {
                        
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    SetView()
}
