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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print ("\(card)")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}

