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
    
    @IBOutlet weak var setTitle: UILabel!
    
    @IBAction func dealMoreCards(_ sender: UIButton) {
        game.deal3NewCards()
        updateViewFromModel()
    }
    
    @IBAction func startAgain(_ sender: UIButton) {
        game = Game()
        updateViewFromModel()
    }
    
    @IBOutlet weak var cardsGrid: CardsGridView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(gridSwipeUpHandler(_:)))
            swipe.direction = [.up]
            cardsGrid.addGestureRecognizer(swipe)
            
            let rotate = UIRotationGestureRecognizer(target: self, action: #selector(gridRotateHandler(_:)))
            cardsGrid.addGestureRecognizer(rotate)
            
            updateViewFromModel()
        }
    }
    
    @objc func gridSwipeUpHandler(_ sender: UISwipeGestureRecognizer) {
        game.deal3NewCards()
        updateViewFromModel()
    }
    
    @objc func gridRotateHandler(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            game.shuffleLoadedCards()
            updateViewFromModel()
        }
    }
    
    var game = Game()
    
    var cardViews = [CardView]()
    
    func updateViewFromModel() {
        cardViews = []
        for index in game.loadedCards.indices {
            let card = game.loadedCards[index]
            let cardView = createCardView(from: card)
            
            if game.matchedCards.contains(card) {
                cardView.layer.borderWidth = 3.0
                cardView.layer.borderColor = UIColor.blue.cgColor
            }
            else if game.selectedCards.contains(card) {
                cardView.layer.borderWidth = 3.0
                cardView.layer.borderColor = UIColor.red.cgColor
            }
            cardViews += [cardView]
        }
        cardsGrid.cardViews = cardViews
        setTitle?.textColor = !game.matchedCards.isEmpty ? UIColor.blue : UIColor.white
        scoreLabel?.text = "SCORE: \(game.score)"
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            if let cardView = recognizer.view as? CardView {
                if let index = cardViews.index(of: cardView) {
                    game.chooseCard(at: index)
                }
                updateViewFromModel()
            }
        }
    }
    
    func createCardView(from card: Card) -> CardView {
        let cardView = CardView()
        cardView.shape = card.shape
        cardView.color = card.color
        cardView.number = card.number
        cardView.shade = card.shade
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognizer:)))
        cardView.addGestureRecognizer(tap)
        return cardView
    }
    
}

