//
//  ViewController.swift
//  PlayingCard
//
//  Created by Анастасия Латыш on 03/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let choosenCardView = recognizer.view as? PlayingCardView {
                UIView.transition(with: choosenCardView, duration: 0.6, options: .transitionFlipFromLeft, animations: {choosenCardView.isFaceUp = !choosenCardView.isFaceUp}, completion: { finished in
                    if self.faceUpCardViewMatch {
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6,
                                                                       delay: 0,
                                                                       options: [],
                                                                       animations: {self.faceUpViews.forEach{ $0.transform = CGAffineTransform.identity.scaledBy(x: 3, y: 3)}
                                                                        
                        },
                                                                       completion: {position in
                                                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.75,
                                                                                                                       delay: 0,
                                                                                                                       options: [],
                                                                                                                       animations: {self.faceUpViews.forEach{ $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                                                                                        $0.alpha = 0
                                                                                                                        }},
                                                                                                                       completion: {position in
                                                                                                                        
                                                                                                                        self.faceUpViews.forEach{
                                                                         $0.isHidden = true
                                                                                                                            $0.alpha = 1
                                                                                                                            $0.transform = .identity
                                                                                                                        }
                                                                                                                        
                                                                        })
                        })
                    }
                    else if self.faceUpViews.count == 2 {
                        self.faceUpViews.forEach{ cardView in
                        UIView.transition(with: cardView,
                                                                       duration: 0.6,
                                                                       options: .transitionFlipFromLeft  ,
                                                                       animations: {cardView.isFaceUp = false}
                            )}
                                                    }
                }
                )
            }
        default:
            break
        }
    }
    
    private var faceUpViews: [PlayingCardView] {
        return cardViews.filter { $0.isFaceUp && !$0.isHidden}
    }
    
    private var faceUpCardViewMatch: Bool {
        return faceUpViews.count == 2 &&
        faceUpViews[0].rank == faceUpViews[1].rank &&
        faceUpViews[0].suit == faceUpViews[1].suit
    }
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    /*  @IBOutlet weak var playingCardView: PlayingCardView! {
     didSet {
     let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
     swipe.direction = [.left , .right]
     playingCardView.addGestureRecognizer(swipe)
     }
     }
     
     @objc func nextCard() {
     if let card = deck.draw() {
     playingCardView.rank = card.rank.order
     playingCardView.suit = card.suit.rawValue
     }
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count + 1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: 0)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
        }
        
    }
    
    
}

