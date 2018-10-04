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
    
    func createIllustrationSubViews() -> [Illustration] {
        var subViewsArray = [Illustration]()
        for times in 1...number {
            guard times <= 3 else { return [] }
            let illustration = Illustration()
            illustration.shapeID = shape
            illustration.colorID = color
            illustration.shadeID = shade
            addSubview(illustration)
            subViewsArray.append(illustration)
        }
        return subViewsArray
    }
    
    func configureIllustrationSubView(_ illustration: Illustration) {
        illustration.isOpaque = false
        illustration.backgroundColor = UIColor.clear
        illustration.frame.size = CGSize(width: illustrationWidth, height: illustrationHeight)
    }
    
    lazy var illustrationSubViewsArray = createIllustrationSubViews()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var offset = illustrationOffsetFromTop
        for illustrationSubView in illustrationSubViewsArray {
            configureIllustrationSubView(illustrationSubView)
            illustrationSubView.frame.origin = bounds.origin.offsetBy(dx: illustrationOffsetFromLeft, dy: offset)
            offset += illustrationHeight + spaceBetweenIllustrations
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
}

extension SetCard {
    struct SizeRatio {
        static let illustrationWidthToBoundsWidth: CGFloat = 0.70
        static let illustrationHeightToBoundsHeight: CGFloat = 0.20
        static let illustrationOffsetFromBoundsLeft: CGFloat = 0.15
        static let spaceBetweenIllustrationsToBoundsHeight: CGFloat = 0.10
    }
    var illustrationWidth: CGFloat {
        return bounds.size.width * SizeRatio.illustrationWidthToBoundsWidth
    }
    var illustrationHeight: CGFloat {
        return bounds.size.height * SizeRatio.illustrationHeightToBoundsHeight
    }
    var illustrationOffsetFromLeft: CGFloat {
        return bounds.size.width * SizeRatio.illustrationOffsetFromBoundsLeft
    }
    var illustrationOffsetFromTop: CGFloat {
        switch number {
        case 1:
            return bounds.size.height * 0.40
        case 2:
            return bounds.size.height * 0.25
        case 3:
            return bounds.size.height * 0.10
        default:
            return 0
        }
    }
    var spaceBetweenIllustrations: CGFloat {
        return bounds.size.height * SizeRatio.spaceBetweenIllustrationsToBoundsHeight
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
