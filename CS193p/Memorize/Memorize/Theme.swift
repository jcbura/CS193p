//
//  Theme.swift
//  Memorize
//
//  Created by jason on 2/22/24.
//

import Foundation

struct Theme {
    var name: String
    var emoji: [String]
    var numberOfPairs: Int
    var color: String
    
    init() {
        let randomTheme = Int.random(in: 1...6)
        switch randomTheme {
        case 1:
            name = "Faces"
            emoji = ["😀", "🥹", "😂", "😇", "😍", "😛", "😎", "🥸", "😤", "🤯", "😶‍🌫️", "🫠", "🥱"]
            numberOfPairs = 10
            color = "red"
        case 2:
            name = "Animals"
            emoji = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"]
            numberOfPairs = 10
            color = "orange"
        case 3:
            name = "Foods"
            emoji = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
            numberOfPairs = 10
            color = "yellow"
        case 4:
            name = "Activities"
            emoji = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸"]
            numberOfPairs = 10
            color = "green"
        case 5:
            name = "Places"
            emoji = ["🗾", "🎑", "🏞️", "🌅", "🌄", "🌠", "🎇", "🎆", "🌇", "🏙️", "🌃", "🌌", "🌉"]
            numberOfPairs = 10
            color = "blue"
        case 6:
            name = "Flags"
            emoji = ["🇺🇸", "🇪🇸", "🇬🇧", "🇫🇷", "🇮🇹", "🇲🇨", "🇦🇹", "🇧🇷", "🇳🇱", "🇹🇷", "🇦🇺", "🇸🇦", "🇦🇿"]
            numberOfPairs = 10
            color = "purple"
        default:
            // Should never reach default case.
            name = ""
            emoji = [""]
            numberOfPairs = 0
            color = ""
        }
        emoji.shuffle()
    }
}
