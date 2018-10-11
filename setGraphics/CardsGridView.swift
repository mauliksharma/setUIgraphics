//
//  CardsGridView.swift
//  setGraphics
//
//  Created by Maulik Sharma on 04/10/18.
//  Copyright © 2018 Geekskool. All rights reserved.
//

import UIKit

class CardsGridView: UIView {
    
    var cardViews = [CardView]() { didSet { setNeedsLayout() } }
    
    var cardsGrid = Grid(layout: .aspectRatio(5/8))
    
    func configureCardSubViews() {
        for index in cardViews.indices {
            cardViews[index].frame = cardsGrid[index]!.zoom(by: 0.9)
        }
    }
    
    func createCardSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
        for cardView in cardViews {
            addSubview(cardView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardsGrid.frame = bounds
        createCardSubviews()
        cardsGrid.cellCount = subviews.count
        configureCardSubViews()
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
