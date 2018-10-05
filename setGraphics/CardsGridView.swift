//
//  CardsGridView.swift
//  setGraphics
//
//  Created by Maulik Sharma on 04/10/18.
//  Copyright © 2018 Geekskool. All rights reserved.
//

import UIKit

//@IBDesignable
class CardsGridView: UIView {
    
    var cardViews = [SetCard]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var cardsGrid = Grid(layout: .aspectRatio(5/8))
    
    func createCardSubviews( ) -> [SetCard] {
        var cardSubViews = [SetCard]()
        for subview in subviews {
            subview.removeFromSuperview()
        }
        for index in cardViews.indices {
            let cardView = cardViews[index]
            addSubview(cardView)
            cardSubViews.append(cardView)
        }
        return cardSubViews
    }
    
    var cardSubViews: [SetCard] {
        return createCardSubviews()
    }
    
    func configureCardSubViews(_ cardSubViews: [SetCard]) {
        for index in cardSubViews.indices {
            cardSubViews[index].frame = cardsGrid[index]!.zoom(by: 0.95)
            cardSubViews[index].backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
    }
    
    override func layoutSubviews() {
        cardsGrid.frame = bounds
        cardsGrid.cellCount = cardViews.count
        configureCardSubViews(cardSubViews)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}

extension CGRect {
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}
