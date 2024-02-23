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
    
    var themeCount = 6
    var themesDictionary: [Int: (String, [String], Int, String)] = [
        1: ("Faces", ["😀", "🥹", "😂", "😇", "😍", "😛", "😎", "🥸", "😤", "🤯", "😶‍🌫️", "🫠", "🥱"], 12, "red"),
        2: ("Animals", ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"], 12, "orange"),
        3: ("Foods", ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"], 12, "yellow"),
        4: ("Activities", ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸"], 12, "green"),
        5: ("Places", ["🗾", "🎑", "🏞️", "🌅", "🌄", "🌠", "🎇", "🎆", "🌇", "🏙️", "🌃", "🌌", "🌉"], 12, "blue"),
        6: ("Flags", ["🇺🇸", "🇪🇸", "🇬🇧", "🇫🇷", "🇮🇹", "🇲🇨", "🇦🇹", "🇧🇷", "🇳🇱", "🇹🇷", "🇦🇺", "🇸🇦", "🇦🇿"], 12, "purple")
    ]
    
    init() {
        let randomTheme = Int.random(in: 1...themeCount)
        if let theme = themesDictionary[randomTheme] {
            name = theme.0
            emoji = theme.1
            numberOfPairs = theme.2
            color = theme.3
            emoji.shuffle()
        } else {
            // Should never be the case.
            name = ""
            emoji = [""]
            numberOfPairs = 0
            color = ""
        }
    }
    
    mutating func addTheme(name: String, emoji: [String], numberOfPairs: Int, color: String) {
        themeCount+=1
        themesDictionary[themeCount] = (name, emoji, numberOfPairs, color)
    }
}
