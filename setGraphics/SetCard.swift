//
//  SetCard.swift
//  setGraphics
//
//  Created by Maulik Sharma on 03/10/18.
//  Copyright © 2018 Geekskool. All rights reserved.
//

import UIKit

@IBDesignable
class SetCard: UIView {

    @IBInspectable
    var shape: Int = 1 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    @IBInspectable
    var number: Int = 1 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    @IBInspectable
    var color: Int = 1 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    @IBInspectable
    var shade: Int = 1 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    
    func createIllustrationSubView() -> Illustration {
        let illustration = Illustration()
        illustration.shapeID = shape
        illustration.colorID = color
        illustration.shadeID = shade
        addSubview(illustration)
        return illustration
    }
    
    func configureIllustrationSubView(_ illustration: Illustration) {
        illustration.isOpaque = false
        illustration.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        illustration.frame.size = CGSize(width: illustrationWidth, height: illustrationHeight)
    }
    
    lazy var illustrationSubView = createIllustrationSubView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch number {
        case 1:
            configureIllustrationSubView(illustrationSubView)
            illustrationSubView.frame.origin = bounds.origin.offsetBy(dx: illustrationOffsetFromLeft, dy: illustrationOffsetFromTopFor1)
        default:
            break //Add code here
        }
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
}


extension SetCard {
    struct SizeRatio {
        static let illustrationWidthToBoundsWidth: CGFloat = 0.75
        static let illustrationHeightToBoundsHeight: CGFloat = 0.25
        static let illustrationOffsetFromBoundsX: CGFloat = 0.125
        static let illustrationOffsetFromBoundsYFor1: CGFloat = 0.375
        
        
        
    }
    
    var illustrationWidth: CGFloat {
        return bounds.size.width * SizeRatio.illustrationWidthToBoundsWidth
    }
    
    var illustrationHeight: CGFloat {
        return bounds.size.height * SizeRatio.illustrationHeightToBoundsHeight
    }
    
    var illustrationOffsetFromLeft: CGFloat {
        return bounds.size.width * SizeRatio.illustrationOffsetFromBoundsX
    }
    
    var illustrationOffsetFromTopFor1: CGFloat {
        return bounds.size.height * SizeRatio.illustrationOffsetFromBoundsYFor1
    }
    
    
}


extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
