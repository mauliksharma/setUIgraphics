//
//  ViewController.swift
//  setGraphics
//
//  Created by Maulik Sharma on 03/10/18.
//  Copyright © 2018 Geekskool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func dealMoreCards(_ sender: UIButton) {
        game.deal3NewCards()
        updateViewFromModel()
    }
    
    @IBAction func startAgain(_ sender: UIButton) {
        game = Game()
        updateViewFromModel()
        scoreLabel.text = "SCORE " + (game.score < 10 ? "0" : "") + "\(game.score)"
    }
    
    @IBOutlet weak var cardsGrid: CardsGridView! {
        didSet {
            updateViewFromModel()
        }
    }
    
    var game = Game()
    
    func updateViewFromModel() {
        var cardViews = [SetCard]()
        for index in game.loadedCards.indices {
            if let card = game.loadedCards[index] {
                let cardView = createSetCardView(shape: card.shape, number: card.number, color: card.color, shade: card.shade)
                print(card)
                cardViews += [cardView]
            }
        }
        cardsGrid.cardViews = cardViews
    }
    
    func createSetCardView(shape: Int, number: Int, color: Int, shade: Int) -> SetCard {
        let card = SetCard()
        card.shape = shape
        card.color = color
        card.number = number
        card.shade = shade
        return card
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

