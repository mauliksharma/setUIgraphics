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
        updateScoreLabelText()
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
            let cardView = createSetCardView(shape: card.shape, number: card.number, color: card.color, shade: card.shade)
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognizer:)))
            cardView.addGestureRecognizer(tap)
            
            if game.matchedCards.contains(card) {
                cardView.layer.borderWidth = 2.0
                cardView.layer.borderColor = UIColor.blue.cgColor
            }
            else if game.selectedCards.contains(card) {
                cardView.layer.borderWidth = 2.0
                cardView.layer.borderColor = UIColor.red.cgColor
            }
            setTitle?.textColor = !game.matchedCards.isEmpty ? UIColor.blue : UIColor.white
            cardViews += [cardView]
        }
        cardsGrid.cardViews = cardViews
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            let cardView = recognizer.view! as! CardView
            if let index = cardViews.index(of: cardView) {
                game.chooseCard(at: index)
            }
            updateViewFromModel()
            updateScoreLabelText()
        }
    }
    
    func updateScoreLabelText() {
        scoreLabel.text = "SCORE: \(game.score)"
    }
    
    func createSetCardView(shape: Int, number: Int, color: Int, shade: Int) -> CardView {
        let card = CardView()
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

