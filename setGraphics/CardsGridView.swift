//
//  CardsGridView.swift
//  setGraphics
//
//  Created by Maulik Sharma on 04/10/18.
//  Copyright © 2018 Geekskool. All rights reserved.
//

import UIKit

class CardsGridView: UIView {
    
    var cardViews = [CardView]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var cardsGrid = Grid(layout: .aspectRatio(5/8))
    
    func configureCardSubViews(_ cardSubViews: [CardView]) {
        for index in cardSubViews.indices {
            cardSubViews[index].frame = cardsGrid[index]!.zoom(by: 0.9)
            cardSubViews[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    override func layoutSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        for cardView in cardViews {
            addSubview(cardView)
        }
        cardsGrid.frame = bounds
        cardsGrid.cellCount = subviews.count
        configureCardSubViews(cardViews)
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
