//
//  ContentView.swift
//  Memorize
//
//  Created by jason on 2/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    
    @State var currentTheme: String?
    
    @State var themeColor: Color?
    
    let animalsArray = ["🐶", "🐶", "🐱", "🐱", "🐹", "🐹", "🐰", "🐰", "🦊", "🦊", "🐻", "🐻", "🐯", "🐯", "🦁", "🦁"]
    
    let foodsArray = ["🍏", "🍏", "🍐", "🍐", "🍊", "🍊", "🍌", "🍌", "🍉", "🍉", "🍇", "🍇", "🫐", "🫐", "🍒", "🍒"]
    
    let sportsArray = ["⚽️", "⚽️", "🏀", "🏀", "🏈", "🏈", "⚾️", "⚾️", "🎾", "🎾", "🏐", "🏐", "🥏", "🥏", "🎱", "🎱"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(themeColor)
    }
    
    var themeAdjusters: some View {
        HStack {
            animalTheme
            Spacer()
            foodTheme
            Spacer()
            sportTheme
        }
    }
    
    func themeAdjuster(themeName: String, array: [String], colorScheme: Color, symbol: String) -> some View {
        Button (action: {
            currentTheme = themeName
            emojis = array.shuffled()
            themeColor = colorScheme
        }, label: {
            VStack {
                Image(systemName: symbol).imageScale(.large).font(.largeTitle)
                Text(themeName)
            }
        })
        .disabled(currentTheme == themeName)
    }
    
    var animalTheme: some View {
        themeAdjuster(themeName: "Animals", array: animalsArray, colorScheme: .green, symbol: "pawprint.circle.fill")
    }
    
    var foodTheme: some View {
        themeAdjuster(themeName: "Foods", array: foodsArray, colorScheme: .blue, symbol: "fork.knife.circle.fill")
    }
    
    var sportTheme: some View {
        themeAdjuster(themeName: "Sports", array: sportsArray, colorScheme: .red, symbol: "football.circle.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
