//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Анастасия Латыш on 03/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    private(set) var cards = [PlayingCard]()
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count - 1)
        } else {
            return nil
        }
    }
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
}
