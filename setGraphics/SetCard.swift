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
    
    class Illustration: UIView {
        
        var shapeID: Int = 1
        var colorID: Int = 1
        var shadeID: Int = 1
        
        func getPath(shapeID: Int) -> UIBezierPath {
            let path = UIBezierPath()
            switch shapeID {
            case 1:
                path.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
                path.addLine(to: CGPoint(x: bounds.minX, y: bounds.midY))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
                path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
                path.close()
            default:
                break
            }
            return path
        }
        
        var color: UIColor {
            switch colorID {
            case 1:
                return .red
            case 2:
                return .green
            case 3:
                return .purple
            default:
                return .black
            }
        }
        
        override func draw(_ rect: CGRect) {
            let path = getPath(shapeID: shapeID)
            path.addClip()
            color.setFill()
            color.setStroke()
            switch shadeID {
            case 1:
                path.fill()
            case 2:
                path.stroke()
            case 3:
                break //Add code here
            default:
                break
            }
        }
    }
    
    func createIllustrationSubView() -> Illustration {
        let illustration = Illustration()
        illustration.shapeID = shape
        illustration.colorID = color
        illustration.shadeID = shade
        addSubview(illustration)
        return illustration
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch number {
        case 1:
            let illustrationSubView = createIllustrationSubView()
            illustrationSubView.frame.origin = bounds.origin.offsetBy(dx: illustrationOffsetFromLeft, dy: illustrationOffsetFromTopFor1)
            illustrationSubView.frame.size.width = illustrationWidth
            illustrationSubView.frame.size.height = illustrationHeight
        default:
            break //Add code here
        }
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
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

extension CGRect {
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
